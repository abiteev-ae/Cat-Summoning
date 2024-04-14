import Foundation

extension FoodEncounterView {
    
    final class ViewModel: ObservableObject {
        enum State {
            case idle
            case playing
            case countingDown
            case lose
            case win
        }
        @Published var readyTime = 3
        @Published var timeRemaining = 30
        @Published var showImmersiveSpace = false
        @Published var foodCounter = 0
        @Published var foodMax = 50
        
        @Published private(set) var state: State = .idle
        @Published private(set) var timeCache = 30

        let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
        func startGame() {
            state = .countingDown
            timeRemaining = timeCache
        }
        
        func loseGame() {
            // Handle game end scenario
            showImmersiveSpace = false
            state = .lose
            timer.upstream.connect().cancel()
        }
        
        func winGame() {
            // Handle game win scenario
            showImmersiveSpace = false
            state = .win
            timer.upstream.connect().cancel()
        }
        
        func resetGame() {
            readyTime = 3
            state = .idle
            timeRemaining = timeCache
        }
        
        func setupTimer(_ time: Int) {
            timeCache = time
        }
        
        func countDownToStart() {
            if readyTime > 1 {
                readyTime -= 1
            } else {
                showImmersiveSpace = true
                state = .playing
                timer.upstream.connect().cancel()
            }
        }
        
        func countDownToLose() {
            if timeRemaining > 1 {
                timeRemaining -= 1
            } else {
                showImmersiveSpace = false
                state = .lose
                timer.upstream.connect().cancel()
            }
        }
    }
}
