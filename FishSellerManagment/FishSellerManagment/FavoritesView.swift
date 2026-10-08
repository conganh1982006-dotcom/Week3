//
//  FavoritesView.swift
//  FishSellerManagment
//
//  Created by MAY 02 on 8/10/26.
//

import SwiftUI

struct FavoritesView: View {

    @EnvironmentObject private var store: StoreViewModel

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {

                if store.favoriteProducts.isEmpty {

                    EmptyStateView(
                        symbol: "heart",
                        title: "No Favorites Yet",
                        message: "Tap the heart icon on a product to save it here."
                    )
                    .padding(.top, 60)

                } else {

                    LazyVGrid(columns: columns, spacing: 12) {
                        ForEach(store.favoriteProducts) { product in
                            ProductCardView(product: product)
                        }
                    }
                    .padding()
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Favorites")
        }
    }
}
