import SwiftUI

//
//@main
//struct LudumDare55App: App {
//    
//    @StateObject var counter = CounterModel()
//    
//    var body: some Scene {
//        WindowGroup {
//            ShootBallView(ShootBallView.ViewModel())
//                .environmentObject(counter)
//        }
//        ImmersiveSpace(id: "ImmersiveSpace") {
//            ShootBallImmersiveView()
//                .environmentObject(counter)
//        }
//    }
//}

@main
struct LudumDare55App: App {
    
    @StateObject private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .frame(minWidth: 640, minHeight: 500)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(viewModel: viewModel)
        }
    }
}
