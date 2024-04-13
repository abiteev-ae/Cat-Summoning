import SwiftUI

struct ShootBallView: View {
    
    @State private var viewModel = ViewModel()
    
    // Environment object to access shagreen data
    @EnvironmentObject var counter: CounterModel
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    
    init(_ viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
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
                    await openImmersiveSpace(id: "ImmersiveSpace")
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
            Text("You Lost!")
                .font(.system(size: 45))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Text("You shot \(counter.ballCounter)/\(counter.ballMax) green balls in \(viewModel.timeCache)s.")
                .font(.system(size: 64))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Button("Try Again!") {
                counter.ballCounter = 0
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
            Text("You shot all \(counter.ballCounter) green balls in \(viewModel.timeCache - viewModel.timeRemaining)s!")
                .font(.system(size: 64))
                .fontWeight(.bold)
            Spacer(minLength: 20)
            Button("Play Again!") {
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
            Text("Shoot \(counter.ballMax) green balls in \(viewModel.timeCache)s!")
                .font(.system(size: 54))
                .fontWeight(.bold)
            settingsView(title: "Time Setting", buttons: timeSettingButtons())
            settingsView(title: "Green Ball Setting", buttons: greenBallSettingButtons())
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

    private func timeSettingButtons() -> some View {
        // Buttons for setting time
        HStack {
            Button("15s") { viewModel.setupTimer(15) }
            Button("30s") { viewModel.setupTimer(30) }
            Button("60s") { viewModel.setupTimer(60) }
        }
    }

    private func greenBallSettingButtons() -> some View {
        // Buttons for setting green ball count
        HStack {
            Button("10") { counter.ballMax = 10 }
            Button("25") { counter.ballMax = 25 }
            Button("50") { counter.ballMax = 50 }
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
            Text("\(counter.ballCounter)/\(counter.ballMax) green balls shot!!")
                .font(.system(size: 52))
                .fontWeight(.semibold)
            Button("Stop") { viewModel.loseGame() }
                .toggleStyle(.button)
                .font(.system(size: 30))
                .fontWeight(.bold)
                .frame(width: 360, height: 120)
        }
        .onReceive(viewModel.timer) { _ in
            if counter.ballCounter >= counter.ballMax {
                viewModel.winGame()
            }
        }
    }
    
    // MARK: - Game Logic


    private func toggleImmersiveSpace() {
        // Toggle immersive space visibility
        Task {
            if viewModel.showImmersiveSpace {
                await openImmersiveSpace(id: "ImmersiveSpace")
            } else {
                await dismissImmersiveSpace()
            }
        }
    }
}

#Preview {
    ShootBallView(ShootBallView.ViewModel())
}
