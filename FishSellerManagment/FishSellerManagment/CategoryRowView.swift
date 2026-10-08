import SwiftUI

struct CategoryRowView: View {

    private let columns = Array(
        repeating: GridItem(.flexible(), spacing: 7),
        count: 4
    )

    var body: some View {
        LazyVGrid(columns: columns, spacing: 12) {

            ForEach(ProductCategory.allCases) { category in
                NavigationLink {
                    CategoryProductsView(category: category)
                } label: {
                    categoryTile(
                        title: category.title,
                        symbol: category.symbol
                    )
                }
                .buttonStyle(.plain)
            }

            NavigationLink {
                FeaturedProductsView()
            } label: {
                categoryTile(
                    title: "Featured",
                    symbol: "star.fill"
                )
            }
            .buttonStyle(.plain)

            NavigationLink {
                DealsView()
            } label: {
                categoryTile(
                    title: "Offers",
                    symbol: "tag.fill"
                )
            }
            .buttonStyle(.plain)
        }
    }

    private func categoryTile(title: String, symbol: String) -> some View {
        VStack(spacing: 7) {

            Image(systemName: symbol)
                .font(.system(size: 26))
                .foregroundStyle(StoreTheme.ocean)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .background(
                    .white,
                    in: RoundedRectangle(cornerRadius: 13)
                )

            Text(title)
                .font(.system(size: 10, weight: .medium))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 27, alignment: .top)
        }
        .frame(maxWidth: .infinity)
    }
}

// Featured products screen
struct FeaturedProductsView: View {

    @EnvironmentObject private var store: StoreViewModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {

                ForEach(store.featuredProducts) { product in
                    ProductCardView(product: product)
                }
            }
            .padding()
        }
        .background(StoreTheme.pale)
        .navigationTitle("Featured Products")
    }
}

// Special offers screen
struct DealsView: View {

    @EnvironmentObject private var store: StoreViewModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {

                ForEach(
                    store.products.filter { $0.oldPrice != nil }
                ) { product in
                    ProductCardView(product: product)
                }
            }
            .padding()
        }
        .background(StoreTheme.pale)
        .navigationTitle("Special Offers")
    }
}
