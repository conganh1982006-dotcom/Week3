import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var store: StoreViewModel

    @State private var searchText = ""
    @State private var submittedQuery = ""
    @State private var showingSearch = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {

                    // Home header and search
                    HomeHeaderView(searchText: $searchText) {
                        submittedQuery = searchText
                        showingSearch = true
                    }

                    // Promotion banner
                    BannerView()

                    // Product categories
                    CategoryRowView()

                    // Featured products title
                    HStack {
                        Text("Featured Products")
                            .font(.headline)

                        Spacer()

                        NavigationLink {
                            FeaturedProductsView()
                        } label: {
                            Text("See All  ›")
                                .font(.subheadline)
                        }
                    }

                    // Horizontal product list
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(alignment: .top, spacing: 12) {

                            ForEach(store.featuredProducts) { product in
                                ProductCardView(product: product)
                                    .frame(width: 148)
                            }
                        }
                        .padding(.vertical, 3)
                    }
                }
                .padding(.horizontal, 15)
                .padding(.top, 10)
                .padding(.bottom, 28)
            }
            .background(StoreTheme.pale)
            .navigationBarTitleDisplayMode(.inline)

            // Open search results
            .navigationDestination(isPresented: $showingSearch) {
                SearchResultsView(query: submittedQuery)
            }
        }
    }
}
