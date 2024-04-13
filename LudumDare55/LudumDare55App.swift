import SwiftUI

@main
struct LudumDare55App: App {
    @StateObject var counter = CounterModel()
    
    var body: some Scene {
        WindowGroup {
            ShootBallView(ShootBallView.ViewModel())
                .environmentObject(counter)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
                .environmentObject(counter)
        }
    }
}
