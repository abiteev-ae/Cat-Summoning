import SwiftUI

struct FoodEncounterView: View {
    

    // Environment object to access shagreen data
    @EnvironmentObject var viewModel: ViewModel
    
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    var body: some View {
        NavigationStack {
            VStack {
                // Display appropriate views based on game state
                switch viewModel.state {
                case .lose:
                    gameOverView()
                case .win:
                    winGameView()
                case .idle:
                    gameSetupView()
                case .countingDown:
                    countdownView()
                case .playing:
                    gamePlayingView()
                }
            }
        }
        .frame(width: 1100, height: 500)
        .onChange(of: viewModel.showImmersiveSpace) { _, newValue in // TODO: replace to viewModel
            // Handle changes in immersive space visibility
            Task {
                if newValue {
                    await openImmersiveSpace(id: "ShootBallImmersiveSpace")
                } else {
                    await dismissImmersiveSpace()
                }
            }
        }
    }

    // MARK: - Game Views
    
    private func gameOverView() -> some View {
        // View displayed when the game is lost
        VStack {
            Text("You Died! Manul Ate you!")
                .font(.system(size: 45))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Text("You have fed manul with \(viewModel.foodCounter)/\(viewModel.foodMax) burgers in \(viewModel.timeCache)s.")
                .font(.system(size: 64))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Button("Try Again!") {
                viewModel.foodCounter = 0
                viewModel.resetGame()
            }
            .toggleStyle(.button)
            .font(.system(size: 30))
            .fontWeight(.bold)
            .frame(width: 360, height: 120)
        }
    }
    
    private func winGameView() -> some View {
        // View displayed when the game is won
        VStack {
            Text("You Win!")
                .font(.system(size: 45))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Text("Congratulations!")
                .font(.system(size: 64))
                .fontWeight(.bold)
            Text("You have successfully survived!")
                .font(.system(size: 64))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Button("Play Again!") {
                viewModel.foodCounter = 0
                viewModel.resetGame()
            }
            .toggleStyle(.button)
            .font(.system(size: 30))
            .fontWeight(.bold)
            .frame(width: 360, height: 120)
        }
    }
    
    private func gameSetupView() -> some View {
        // View for setting up the game
        VStack {
            Text("Feed manul with \(viewModel.foodMax) burgers in \(viewModel.timeCache)s!")
                .font(.system(size: 54))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            startGameButton()
        }
    }
    
    private func settingsView(title: String, buttons: some View) -> some View {
        // View for displaying settings
        VStack {
            Text(title)
                .font(.system(size: 28))
                .padding(.top, 20)
                .padding(.bottom, 10)
            buttons
        }
    }

    private func startGameButton() -> some View {
        // Button to start the game
        Button("Play") {
            viewModel.startGame()
        }
        .toggleStyle(.button)
        .font(.system(size: 30))
        .fontWeight(.bold)
        .frame(width: 360, height: 120)
    }

    private func countdownView() -> some View {
        // View for the countdown before the game starts
        Text("\(viewModel.readyTime)")
            .font(.system(size: 160))
            .fontWeight(.bold)
            .onReceive(viewModel.timer) { _ in
                viewModel.countDownToStart()
            }
    }

    private func gamePlayingView() -> some View {
        // View for playing the game
        VStack {
            Text("\(viewModel.timeRemaining)")
                .font(.system(size: 142))
                .fontWeight(.bold)
                .onReceive(viewModel.timer) { _ in
                    viewModel.countDownToLose()
                }
            Text("\(viewModel.foodCounter) of \(viewModel.foodMax) burgers !!")
                .font(.system(size: 52))
                .fontWeight(.semibold)
            Text("You have \(viewModel.life) of 5 life")
                .font(.system(size: 52))
                .fontWeight(.semibold)
            Button("Stop") {
                viewModel.loseGame()
            }
                .toggleStyle(.button)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .frame(width: 360, height: 120)
        }
        .onReceive(viewModel.timer) { _ in
            if viewModel.foodCounter >= viewModel.foodMax {
                viewModel.winGame()
            }
        }
    }
    
    // MARK: - Game Logic


    private func toggleImmersiveSpace() {
        // Toggle immersive space visibility
        Task {
            if viewModel.showImmersiveSpace {
                await openImmersiveSpace(id: "ShootBallImmersiveSpace")
            } else {
                await dismissImmersiveSpace()
            }
        }
    }
}

#Preview {
    FoodEncounterView()
}
