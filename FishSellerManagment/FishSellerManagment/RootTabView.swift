import SwiftUI

struct RootTabView: View {

    @EnvironmentObject private var store: StoreViewModel

    var body: some View {
        TabView {

            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            CategoriesView()
                .tabItem {
                    Label("Categories", systemImage: "square.grid.2x2")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            NavigationStack {
                OrdersView()
            }
            .tabItem {
                Label("Orders", systemImage: "shippingbox")
            }

            ProfileView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
        }
        .tint(StoreTheme.ocean)
    }
}
