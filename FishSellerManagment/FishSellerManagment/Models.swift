import Foundation

enum ProductCategory: String, CaseIterable, Codable, Identifiable {
    case fish, plants, decorations, equipment, food, accessories

    var id: String { rawValue }

    var title: String {
        switch self {
        case .fish: return "Fish"
        case .plants: return "Aquatic Plants"
        case .decorations: return "Decorations"
        case .equipment: return "Equipment"
        case .food: return "Fish Food"
        case .accessories: return "Accessories"
        }
    }

    var symbol: String {
        switch self {
        case .fish: return "fish.fill"
        case .plants: return "leaf.fill"
        case .decorations: return "mountain.2.fill"
        case .equipment: return "drop.fill"
        case .food: return "shippingbox.fill"
        case .accessories: return "wrench.adjustable.fill"
        }
    }
}

// Product information
struct Product: Identifiable, Codable, Hashable {
    let id: String
    let name: String
    let category: ProductCategory
    let price: Int
    let oldPrice: Int?
    let imageName: String
    let description: String
    let stock: Int
    let rating: Double
    let isFeatured: Bool
}

// Shopping cart item
struct CartItem: Identifiable, Codable {
    let productID: String
    var quantity: Int

    var id: String { productID }
}

// Product and quantity for display
struct CartLine: Identifiable {
    let product: Product
    let quantity: Int

    var id: String { product.id }
    var subtotal: Int { product.price * quantity }
}

// One product inside an order
struct OrderItem: Codable, Identifiable {
    let productID: String
    let name: String
    let quantity: Int
    let unitPrice: Int

    var id: String { productID }
    var subtotal: Int { quantity * unitPrice }
}

// Customer order
struct StoreOrder: Identifiable, Codable {
    let id: UUID
    let createdAt: Date
    let items: [OrderItem]
    let total: Int
    let customerName: String
    let phone: String
    let address: String
    let note: String
}

// Customer profile
struct CustomerProfile: Codable {
    var name: String = ""
    var phone: String = ""
    var address: String = ""
}

// Local saved data
struct SavedStore: Codable {
    var favoriteIDs: [String]
    var cart: [CartItem]
    var orders: [StoreOrder]
    var profile: CustomerProfile
}
