import SwiftUI

struct BannerView: View {

    var body: some View {
        NavigationLink {
            DealsView()
        } label: {

            ZStack(alignment: .leading) {
                ProductImageView(
                    imageName: "banner_home",
                    symbol: "fish.fill"
                )
                .frame(height: 155)
                .clipped()

                LinearGradient(
                    colors: [
                        Color.white.opacity(0.95),
                        Color.white.opacity(0.45),
                        .clear
                    ],
                    startPoint: .leading,
                    endPoint: .trailing
                )

                HStack {
                    VStack(alignment: .leading, spacing: 7) {

                        Text("AQUARIUM SPECIAL")
                            .font(.caption2.bold())
                            .foregroundStyle(.blue)

                        Text("Healthy Fish\nBeautiful Tanks")
                            .font(.title3.bold())
                            .foregroundStyle(.black)

                        Text("Discover special offers  ›")
                            .font(.caption.bold())
                            .foregroundStyle(StoreTheme.ocean)
                    }

                    Spacer()

                    Text("SALE")
                        .font(.caption.bold())
                        .padding(12)
                        .foregroundStyle(.white)
                        .background(.orange, in: Circle())
                }
                .padding(16)
            }
            .frame(height: 155)
            .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .buttonStyle(.plain)
    }
}
