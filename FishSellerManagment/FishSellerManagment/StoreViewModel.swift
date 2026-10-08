import SwiftUI
import Combine
final class StoreViewModel: ObservableObject {

    let products = SampleData.products

    @Published private(set) var favoriteIDs: Set<String> = []
    @Published private(set) var cart: [CartItem] = []
    @Published private(set) var orders: [StoreOrder] = []
    @Published private(set) var profile = CustomerProfile()

    private let saveKey = "FishSellerManagment_v1"

    init() {
        guard let data = UserDefaults.standard.data(forKey: saveKey),
              let saved = try? JSONDecoder().decode(SavedStore.self, from: data) else {
            return
        }

        favoriteIDs = Set(saved.favoriteIDs)

        cart = saved.cart.filter { item in
            products.contains(where: { $0.id == item.productID }) &&
            item.quantity > 0
        }

        orders = saved.orders
        profile = saved.profile
    }

    // Find a product by ID
    func product(withID id: String) -> Product? {
        products.first { $0.id == id }
    }

    // Get featured products
    var featuredProducts: [Product] {
        products.filter { $0.isFeatured }
    }

    // Filter by category
    func products(in category: ProductCategory) -> [Product] {
        products.filter { $0.category == category }
    }

    // Search products
    func search(_ query: String) -> [Product] {
        let keyword = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !keyword.isEmpty else {
            return products
        }

        return products.filter { product in
            [product.name, product.category.title, product.description].contains { text in
                text.range(
                    of: keyword,
                    options: [.caseInsensitive, .diacriticInsensitive]
                ) != nil
            }
        }
    }

    // Check favorite
    func isFavorite(_ id: String) -> Bool {
        favoriteIDs.contains(id)
    }

    // Get favorite products
    var favoriteProducts: [Product] {
        products.filter { favoriteIDs.contains($0.id) }
    }

    // Add or remove favorite
    func toggleFavorite(_ id: String) {
        if favoriteIDs.contains(id) {
            favoriteIDs.remove(id)
        } else {
            favoriteIDs.insert(id)
        }

        persist()
    }

    // Add product to cart
    @discardableResult
    func addToCart(_ id: String) -> Bool {
        guard let product = product(withID: id),
              product.stock > 0 else {
            return false
        }

        if let index = cart.firstIndex(where: { $0.productID == id }) {
            guard cart[index].quantity < product.stock else {
                return false
            }

            cart[index].quantity += 1
        } else {
            cart.append(CartItem(productID: id, quantity: 1))
        }

        persist()
        return true
    }

    // Update cart quantity
    func setQuantity(for id: String, to quantity: Int) {
        guard let product = product(withID: id) else {
            return
        }

        if quantity <= 0 {
            removeFromCart(id)
            return
        }

        guard let index = cart.firstIndex(where: { $0.productID == id }) else {
            return
        }

        cart[index].quantity = min(quantity, product.stock)
        persist()
    }

    // Remove product from cart
    func removeFromCart(_ id: String) {
        cart.removeAll { $0.productID == id }
        persist()
    }

    // Cart display data
    var cartLines: [CartLine] {
        cart.compactMap { item in
            guard let product = product(withID: item.productID) else {
                return nil
            }

            return CartLine(
                product: product,
                quantity: item.quantity
            )
        }
    }

    // Total cart quantity
    var cartCount: Int {
        cart.reduce(0) { $0 + $1.quantity }
    }

    // Total cart price
    var cartTotal: Int {
        cartLines.reduce(0) { $0 + $1.subtotal }
    }

    // Save customer profile
    func saveProfile(name: String, phone: String, address: String) {
        profile = CustomerProfile(
            name: name,
            phone: phone,
            address: address
        )

        persist()
    }

    // Create a local demo order
    @discardableResult
    func placeOrder(
        name: String,
        phone: String,
        address: String,
        note: String
    ) -> StoreOrder? {

        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanAddress = address.trimmingCharacters(in: .whitespacesAndNewlines)
        let phoneDigits = cleanPhone.filter { $0.isNumber }

        guard !cartLines.isEmpty,
              !cleanName.isEmpty,
              !cleanAddress.isEmpty,
              phoneDigits.count >= 9,
              phoneDigits.count <= 11,
              phoneDigits.count == cleanPhone.count else {
            return nil
        }

        let items = cartLines.map { line in
            OrderItem(
                productID: line.product.id,
                name: line.product.name,
                quantity: line.quantity,
                unitPrice: line.product.price
            )
        }

        let order = StoreOrder(
            id: UUID(),
            createdAt: Date(),
            items: items,
            total: cartTotal,
            customerName: cleanName,
            phone: cleanPhone,
            address: cleanAddress,
            note: note
        )

        orders.insert(order, at: 0)

        profile = CustomerProfile(
            name: cleanName,
            phone: cleanPhone,
            address: cleanAddress
        )

        cart.removeAll()
        persist()

        return order
    }

    // Save data to the device
    private func persist() {
        let saved = SavedStore(
            favoriteIDs: Array(favoriteIDs),
            cart: cart,
            orders: orders,
            profile: profile
        )

        guard let data = try? JSONEncoder().encode(saved) else {
            return
        }

        UserDefaults.standard.set(data, forKey: saveKey)
    }
}
