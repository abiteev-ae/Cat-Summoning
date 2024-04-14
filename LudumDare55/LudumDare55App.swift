import SwiftUI


@main
struct LudumDare55App: App {
    
    @StateObject private var foodEncounterViewModel = FoodEncounterView.ViewModel()
    @StateObject private var viewModel = AppViewModel()
    
    var body: some Scene {
        WindowGroup {
            ScrollView {
                FoodEncounterView()
                    .environmentObject(foodEncounterViewModel)
                
                ContentView(viewModel: viewModel)
                    .frame(minWidth: 640, minHeight: 500)
            }
        }
        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(viewModel: viewModel)
        }
        ImmersiveSpace(id: "ShootBallImmersiveSpace") {
            FoodEncounterImmersiveView()
                .environmentObject(foodEncounterViewModel)
        }
        
    }
}
