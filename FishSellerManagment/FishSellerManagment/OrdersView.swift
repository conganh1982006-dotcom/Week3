//
//  OrdersView.swift
//  FishSellerManagment
//
//  Created by MAY 02 on 8/10/26.
//

import SwiftUI

struct OrdersView: View {

    @EnvironmentObject private var store: StoreViewModel

    var body: some View {
        Group {

            if store.orders.isEmpty {

                EmptyStateView(
                    symbol: "shippingbox",
                    title: "No Orders Yet",
                    message: "Orders placed through checkout will appear here."
                )

            } else {

                List(store.orders) { order in
                    NavigationLink {
                        OrderDetailView(order: order)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {

                            Text(
                                "Order #\(String(order.id.uuidString.prefix(8)).uppercased())"
                            )
                            .font(.headline)

                            Text(order.createdAt, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text(PriceText.format(order.total))
                                .foregroundStyle(StoreTheme.ocean)
                        }
                    }
                }
            }
        }
        .navigationTitle("My Orders")
    }
}

// Order details
struct OrderDetailView: View {

    let order: StoreOrder

    var body: some View {
        List {

            Section("Order Information") {

                LabeledContent("Order Date") {
                    Text(order.createdAt, style: .date)
                }

                LabeledContent(
                    "Customer",
                    value: order.customerName
                )

                LabeledContent(
                    "Phone",
                    value: order.phone
                )

                Text("Address: \(order.address)")

                if !order.note.isEmpty {
                    Text("Notes: \(order.note)")
                }
            }

            Section("Products") {

                ForEach(order.items) { item in
                    VStack(alignment: .leading, spacing: 5) {

                        Text("\(item.name) × \(item.quantity)")

                        Text(PriceText.format(item.subtotal))
                            .foregroundStyle(.secondary)
                    }
                }
            }

            Section {

                LabeledContent(
                    "Order Total",
                    value: PriceText.format(order.total)
                )

                Text("This order is stored locally and has not been sent to a real store.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .navigationTitle("Order Details")
    }
}
