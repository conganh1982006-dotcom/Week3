//
//  CartView.swift
//  FishSellerManagment
//
//  Created by MAY 02 on 8/10/26.
//

import SwiftUI

struct CartView: View {

    @EnvironmentObject private var store: StoreViewModel

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                if store.cartLines.isEmpty {

                    Spacer()

                    EmptyStateView(
                        symbol: "cart",
                        title: "Your Cart is Empty",
                        message: "Choose a product and tap Add to Cart."
                    )

                    Spacer()

                } else {

                    List {
                        ForEach(store.cartLines) { line in
                            CartItemRowView(line: line)
                        }
                    }
                    .listStyle(.plain)

                    VStack(spacing: 12) {

                        HStack {
                            Text("Total Items: \(store.cartCount)")

                            Spacer()

                            Text(PriceText.format(store.cartTotal))
                                .bold()
                                .foregroundStyle(StoreTheme.ocean)
                        }

                        NavigationLink {
                            CheckoutView()
                        } label: {
                            Text("Proceed to Checkout")
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity)
                                .padding(14)
                                .background(
                                    StoreTheme.ocean,
                                    in: RoundedRectangle(cornerRadius: 12)
                                )
                                .foregroundStyle(.white)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Shopping Cart")
        }
    }
}
