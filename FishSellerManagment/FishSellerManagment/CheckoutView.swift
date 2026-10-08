import SwiftUI

struct CheckoutView: View {

    @EnvironmentObject private var store: StoreViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var phone = ""
    @State private var address = ""
    @State private var note = ""

    @State private var showAlert = false
    @State private var orderSuccess = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""

    var body: some View {
        Form {

            // Customer information
            Section("Delivery Information") {

                TextField("Full Name", text: $name)

                TextField("Phone Number", text: $phone)
                    .keyboardType(.phonePad)

                TextField(
                    "Delivery Address",
                    text: $address,
                    axis: .vertical
                )
                .lineLimit(2...4)

                TextField(
                    "Additional Notes (Optional)",
                    text: $note,
                    axis: .vertical
                )
                .lineLimit(2...4)
            }

            // Order summary
            Section("Order Summary") {

                ForEach(store.cartLines) { line in
                    HStack {
                        Text("\(line.product.name) × \(line.quantity)")

                        Spacer()

                        Text(PriceText.format(line.subtotal))
                    }
                    .font(.subheadline)
                }

                HStack {
                    Text("Total")
                        .bold()

                    Spacer()

                    Text(PriceText.format(store.cartTotal))
                        .bold()
                }
            }

            // Payment method
            Section("Payment Method") {

                Label(
                    "Cash on Delivery (Demo)",
                    systemImage: "banknote"
                )

                Text("This is a demonstration app. No real payment or order will be processed.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            // Place order
            Section {
                Button {
                    placeOrder()
                } label: {
                    Text("Confirm Order")
                        .bold()
                        .frame(maxWidth: .infinity)
                }
                .disabled(store.cartLines.isEmpty)
            }
        }
        .navigationTitle("Checkout")

        .onAppear {
            name = store.profile.name
            phone = store.profile.phone
            address = store.profile.address
        }

        .alert(alertTitle, isPresented: $showAlert) {
            Button("OK") {
                if orderSuccess {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    // Validate and create order
    func placeOrder() {

        if let order = store.placeOrder(
            name: name,
            phone: phone,
            address: address,
            note: note
        ) {

            orderSuccess = true
            alertTitle = "Order Placed Successfully"

            let orderCode = String(
                order.id.uuidString.prefix(8)
            ).uppercased()

            alertMessage = "Your demo order number is \(orderCode). You can view it in Orders."

        } else {

            orderSuccess = false
            alertTitle = "Invalid Information"
            alertMessage = "Please enter your name, delivery address, and a valid 9–11 digit phone number."
        }

        showAlert = true
    }
}
