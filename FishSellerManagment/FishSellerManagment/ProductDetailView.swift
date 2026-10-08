import SwiftUI

struct ProductDetailView: View {

    @EnvironmentObject private var store: StoreViewModel

    let productID: String

    @State private var showingMessage = false
    @State private var feedback = ""

    var body: some View {
        Group {

            if let product = store.product(withID: productID) {

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {

                        ProductImageView(
                            imageName: product.imageName,
                            symbol: product.category.symbol
                        )
                        .frame(height: 280)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 16)
                        )

                        HStack(alignment: .top) {

                            VStack(alignment: .leading, spacing: 6) {
                                Text(product.name)
                                    .font(.title2.bold())

                                Text(product.category.title)
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            // Favorite button
                            Button {
                                store.toggleFavorite(product.id)
                            } label: {
                                Image(
                                    systemName: store.isFavorite(product.id)
                                        ? "heart.fill" : "heart"
                                )
                                .font(.title2)
                                .foregroundStyle(.pink)
                            }
                            .accessibilityLabel("Favorite")
                        }

                        // Product price
                        Text(PriceText.format(product.price))
                            .font(.title2.bold())
                            .foregroundStyle(StoreTheme.ocean)

                        HStack {
                            Label(
                                String(format: "%.1f", product.rating),
                                systemImage: "star.fill"
                            )
                            .foregroundStyle(.orange)

                            Spacer()

                            Text("Stock: \(product.stock)")
                                .foregroundStyle(.secondary)
                        }
                        .font(.subheadline)

                        Text("Description")
                            .font(.headline)

                        Text(product.description)
                            .foregroundStyle(.secondary)

                        // Add to cart
                        Button {
                            feedback = store.addToCart(product.id)
                                ? "\(product.name) was added to your cart."
                                : "Cannot add product. Stock limit reached."

                            showingMessage = true
                        } label: {
                            Label(
                                "Add to Cart",
                                systemImage: "cart.badge.plus"
                            )
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(StoreTheme.ocean)
                    }
                    .padding()
                }

            } else {

                EmptyStateView(
                    symbol: "exclamationmark.circle",
                    title: "Product Not Found",
                    message: "This product is no longer available."
                )
            }
        }
        .navigationTitle("Product Details")
        .navigationBarTitleDisplayMode(.inline)

        .alert("Notification", isPresented: $showingMessage) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(feedback)
        }
    }
}
