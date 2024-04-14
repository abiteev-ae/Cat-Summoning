import SwiftUI


@main
struct LudumDare55App: App {
    
    @StateObject private var foodEncounterViewModel = FoodEncounterView.ViewModel()
    @StateObject private var viewModel = AppViewModel()
    
    @State private var immersionStyle: ImmersionStyle = .mixed
    
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
        ImmersiveSpace(id: "PortalSpace") {
            PortalView()
        }
        .immersionStyle(selection: $immersionStyle, in: .mixed)
    }
}
