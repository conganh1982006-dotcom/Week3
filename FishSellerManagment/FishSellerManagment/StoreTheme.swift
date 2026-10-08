import SwiftUI

enum StoreTheme {
    static let ocean = Color(red: 0.09, green: 0.50, blue: 0.78)
    static let aqua = Color(red: 0.17, green: 0.68, blue: 0.64)
    static let pale = Color(red: 0.94, green: 0.98, blue: 0.98)
}

enum PriceText {
    static func format(_ amount: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = "."

        return (formatter.string(from: NSNumber(value: amount)) ?? "\(amount)") + " VND"
    }
}
