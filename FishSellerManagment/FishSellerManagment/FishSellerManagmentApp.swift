import SwiftUI

@main
struct FishSellerManagmentApp: App {

    @StateObject private var store = StoreViewModel()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(store)
        }
    }
}
