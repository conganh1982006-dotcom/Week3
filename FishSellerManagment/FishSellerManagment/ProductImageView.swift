import SwiftUI
import UIKit

struct ProductImageView: View {
    let imageName: String
    var symbol: String = "fish.fill"

    var body: some View {
        GeometryReader { geometry in
            if let image = UIImage(named: imageName) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height
                    )
                    .clipped()
            } else {
                ZStack {
                    Color(red: 0.88, green: 0.96, blue: 0.95)

                    Image(systemName: symbol)
                        .font(.system(size: 31))
                        .foregroundStyle(StoreTheme.ocean.opacity(0.35))
                }
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
        }
        .accessibilityLabel("Product image")
    }
}
