//
//  ProfileView.swift
//  FishSellerManagment
//
//  Created by MAY 02 on 8/10/26.
//

import SwiftUI

struct ProfileView: View {

    @EnvironmentObject private var store: StoreViewModel

    @State private var name = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var showingSaved = false

    var body: some View {
        NavigationStack {
            Form {

                Section("Account Information (Demo)") {

                    TextField("Customer Name", text: $name)

                    TextField("Phone Number", text: $phone)
                        .keyboardType(.phonePad)

                    TextField(
                        "Delivery Address",
                        text: $address,
                        axis: .vertical
                    )
                    .lineLimit(2...4)

                    Button("Save Information") {
                        store.saveProfile(
                            name: name,
                            phone: phone,
                            address: address
                        )

                        showingSaved = true
                    }
                }

                Section("Shopping") {

                    NavigationLink {
                        OrdersView()
                    } label: {
                        Label(
                            "My Orders (\(store.orders.count))",
                            systemImage: "shippingbox"
                        )
                    }
                }

                Section("About") {

                    Text("Fish Seller Management · SwiftUI Project")

                    Text("Data is stored on this device. There is no real login, server connection, or online payment.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("Account")

            .onAppear {
                name = store.profile.name
                phone = store.profile.phone
                address = store.profile.address
            }

            .alert(
                "Information Saved",
                isPresented: $showingSaved
            ) {
                Button("OK", role: .cancel) { }
            }
        }
    }
}

