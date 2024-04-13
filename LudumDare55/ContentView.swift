import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        HomeView(viewModel: viewModel)
    }
}
