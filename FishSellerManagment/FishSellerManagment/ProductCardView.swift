import SwiftUI

struct ProductCardView: View {
    @EnvironmentObject private var store: StoreViewModel
    let product: Product

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {

            ZStack(alignment: .topTrailing) {

                NavigationLink {
                    ProductDetailView(productID: product.id)
                } label: {
                    ProductImageView(
                        imageName: product.imageName,
                        symbol: product.category.symbol
                    )
                    .frame(height: 108)
                    .clipShape(RoundedRectangle(cornerRadius: 11))
                }
                .buttonStyle(.plain)

                // Favorite button
                Button {
                    store.toggleFavorite(product.id)
                } label: {
                    Image(
                        systemName: store.isFavorite(product.id)
                            ? "heart.fill" : "heart"
                    )
                    .font(.system(size: 15, weight: .medium))
                    .foregroundStyle(
                        store.isFavorite(product.id) ? .pink : .gray
                    )
                    .frame(width: 30, height: 30)
                    .background(.white, in: Circle())
                }
                .padding(6)
                .accessibilityLabel(
                    store.isFavorite(product.id)
                        ? "Remove favorite" : "Add favorite"
                )
            }

            NavigationLink {
                ProductDetailView(productID: product.id)
            } label: {
                VStack(alignment: .leading, spacing: 5) {

                    Text(product.name)
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .frame(height: 31, alignment: .topLeading)

                    Text(PriceText.format(product.price))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(.red)

                    if let oldPrice = product.oldPrice {
                        Text(PriceText.format(oldPrice))
                            .font(.system(size: 10))
                            .strikethrough()
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .buttonStyle(.plain)
        }
        .padding(8)
        .background(.white, in: RoundedRectangle(cornerRadius: 14))
    }
}
