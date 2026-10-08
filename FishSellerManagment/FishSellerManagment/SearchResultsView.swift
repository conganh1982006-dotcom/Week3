import SwiftUI
import Combine
struct SearchResultsView: View {

    @EnvironmentObject private var store: StoreViewModel

    let query: String

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {

        let results = store.search(query)

        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                Text(
                    query.trimmingCharacters(
                        in: .whitespacesAndNewlines
                    ).isEmpty
                    ? "All Products"
                    : "Search: \"\(query)\""
                )
                .font(.headline)

                Text("\(results.count) results")
                    .foregroundStyle(.secondary)
                    .font(.subheadline)

                if results.isEmpty {

                    EmptyStateView(
                        symbol: "magnifyingglass",
                        title: "No Products Found",
                        message: "Try searching for another fish, plant, or category."
                    )

                } else {

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(results) { product in
                            ProductCardView(product: product)
                        }
                    }
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Search Results")
        .navigationBarTitleDisplayMode(.inline)
    }
}
