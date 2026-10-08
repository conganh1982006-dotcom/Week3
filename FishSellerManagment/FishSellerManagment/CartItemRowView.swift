import SwiftUI

struct CartItemRowView: View {

    @EnvironmentObject private var store: StoreViewModel
    let line: CartLine

    var body: some View {
        HStack(spacing: 12) {

            NavigationLink {
                ProductDetailView(productID: line.product.id)
            } label: {
                ProductImageView(
                    imageName: line.product.imageName,
                    symbol: line.product.category.symbol
                )
                .frame(width: 80, height: 80)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 8) {

                Text(line.product.name)
                    .font(.subheadline.bold())

                Text(PriceText.format(line.subtotal))
                    .font(.subheadline)
                    .foregroundStyle(StoreTheme.ocean)

                HStack(spacing: 14) {

                    Button {
                        store.setQuantity(
                            for: line.product.id,
                            to: line.quantity - 1
                        )
                    } label: {
                        Image(systemName: "minus.circle")
                    }

                    Text("\(line.quantity)")
                        .monospacedDigit()

                    Button {
                        store.setQuantity(
                            for: line.product.id,
                            to: line.quantity + 1
                        )
                    } label: {
                        Image(systemName: "plus.circle")
                    }
                    .disabled(line.quantity >= line.product.stock)

                    Spacer()

                    Button(role: .destructive) {
                        store.removeFromCart(line.product.id)
                    } label: {
                        Image(systemName: "trash")
                    }
                    .accessibilityLabel("Remove from cart")
                }
                .buttonStyle(.borderless)
            }
        }
        .padding(.vertical, 7)
    }
}
