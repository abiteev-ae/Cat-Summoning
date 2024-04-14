import SwiftUI
import AVFAudio


@main
struct LudumDare55App: App {
    
    @StateObject private var foodEncounterViewModel = FoodEncounterView.ViewModel()
    @StateObject private var viewModel = AppViewModel()
    @State private var immersionStyle: ImmersionStyle = .mixed
    @State var audioPlayer: AVAudioPlayer!
    var body: some Scene {
        WindowGroup {
            ScrollView {
                ContentView(viewModel: viewModel)
                    .frame(minWidth: 640, minHeight: 500)
                    .onAppear() {
                        let sound = Bundle.main.path(forResource: "ДИКИЕ РЫСИ - Пиздец [music]", ofType: "mp3")
                        self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
                        self.audioPlayer.numberOfLoops = -1
                        self.audioPlayer.volume = 0.3 // Set the volume to half the maximum volume
                        self.audioPlayer.play()
                    }
                FoodEncounterView()
                    .environmentObject(foodEncounterViewModel)
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
