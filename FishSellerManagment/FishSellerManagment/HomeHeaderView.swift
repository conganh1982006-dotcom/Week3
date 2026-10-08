import SwiftUI

struct HomeHeaderView: View {

    @EnvironmentObject private var store: StoreViewModel

    @Binding var searchText: String
    let onSearch: () -> Void

    @State private var showCart = false
    @State private var showOffersAlert = false
    @State private var showAddressEditor = false
    @State private var addressText = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 13) {

            HStack(spacing: 9) {

                Image(systemName: "fish.circle.fill")
                    .font(.system(size: 36))
                    .foregroundStyle(StoreTheme.ocean)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Cá Cảnh Xanh")
                        .font(.title3.bold())
                        .foregroundStyle(.primary)

                    Text("Your friendly aquarium store")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }

                Spacer(minLength: 8)

                // Notification button
                Button {
                    showOffersAlert = true
                } label: {
                    Image(systemName: "bell")
                        .font(.title3)
                }
                .accessibilityLabel("Store announcements")

                // Shopping cart button
                Button {
                    showCart = true
                } label: {
                    ZStack(alignment: .topTrailing) {

                        Image(systemName: "cart.fill")
                            .font(.title3)
                            .padding(.trailing, 7)

                        if store.cartCount > 0 {
                            Text("\(store.cartCount)")
                                .font(.system(size: 10, weight: .bold))
                                .foregroundStyle(.white)
                                .padding(4)
                                .background(.red, in: Circle())
                                .offset(x: 4, y: -7)
                        }
                    }
                }
                .accessibilityLabel("Shopping cart")
            }
            .foregroundStyle(StoreTheme.ocean)

            // Delivery address
            Button {
                addressText = store.profile.address
                showAddressEditor = true
            } label: {
                HStack(spacing: 7) {

                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(StoreTheme.ocean)

                    Text(
                        store.profile.address.isEmpty
                            ? "Choose your delivery address"
                            : store.profile.address
                    )
                    .lineLimit(1)
                    .font(.subheadline)
                    .foregroundStyle(.primary)

                    Spacer(minLength: 0)

                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            // Search field
            HStack(spacing: 10) {

                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)

                TextField(
                    "Search fish, plants, aquarium supplies...",
                    text: $searchText
                )
                .font(.subheadline)
                .submitLabel(.search)
                .onSubmit(onSearch)

                Button(action: onSearch) {
                    Image(systemName: "arrow.right.circle.fill")
                        .font(.title3)
                        .foregroundStyle(StoreTheme.ocean)
                }
                .accessibilityLabel("Search products")
            }
            .padding(12)
            .background(
                .white,
                in: RoundedRectangle(cornerRadius: 13)
            )
        }
        .padding(14)
        .background(
            .white,
            in: RoundedRectangle(cornerRadius: 20)
        )

        // Open shopping cart
        .sheet(isPresented: $showCart) {
            CartView()
        }

        // Edit delivery address
        .sheet(isPresented: $showAddressEditor) {
            NavigationStack {
                Form {
                    TextField(
                        "Delivery address",
                        text: $addressText,
                        axis: .vertical
                    )
                    .lineLimit(2...4)
                }
                .navigationTitle("Delivery Address")
                .toolbar {
                    ToolbarItem(placement: .confirmationAction) {
                        Button("Save") {
                            store.saveProfile(
                                name: store.profile.name,
                                phone: store.profile.phone,
                                address: addressText
                            )
                            showAddressEditor = false
                        }
                    }

                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            showAddressEditor = false
                        }
                    }
                }
            }
        }

        // Store announcements
        .alert("Store Announcements", isPresented: $showOffersAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Check Special Offers for discounted products.")
        }
    }
}
