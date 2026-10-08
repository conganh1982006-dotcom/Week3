//
//  CategoriesView.swift
//  FishSellerManagment
//
//  Created by MAY 02 on 8/10/26.
//

import SwiftUI

struct CategoriesView: View {

    var body: some View {
        NavigationStack {
            CategoriesListView()
                .navigationTitle("Categories")
        }
    }
}

// Category grid
struct CategoriesListView: View {

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 14) {

                ForEach(ProductCategory.allCases) { category in
                    NavigationLink {
                        CategoryProductsView(category: category)
                    } label: {
                        VStack(spacing: 12) {

                            Image(systemName: category.symbol)
                                .font(.system(size: 32))
                                .foregroundStyle(StoreTheme.ocean)

                            Text(category.title)
                                .font(.headline)
                                .foregroundStyle(.primary)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 125)
                        .background(
                            StoreTheme.pale,
                            in: RoundedRectangle(cornerRadius: 18)
                        )
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
    }
}

// Products belonging to a category
struct CategoryProductsView: View {

    @EnvironmentObject private var store: StoreViewModel
    let category: ProductCategory

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {

                ForEach(store.products(in: category)) { product in
                    ProductCardView(product: product)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(category.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
