import Foundation

extension ShootBallView {
    @Observable
    class ViewModel {
        enum State {
            case idle
            case playing
            case countingDown
            case lose
            case win
        }
        var readyTime = 3
        var timeRemaining = 30
        var showImmersiveSpace = false
    
        private(set) var state: State = .idle
        private(set) var timeCache = 30

        @ObservationIgnored let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
        
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
                state = .playing
                showImmersiveSpace = true
                timer.upstream.connect().cancel()
            }
        }
        
        func countDownToLose() {
            if readyTime > 1 {
                readyTime -= 1
            } else {
                showImmersiveSpace = true
                timer.upstream.connect().cancel()
            }
        }
    }
}
