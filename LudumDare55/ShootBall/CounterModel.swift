import Foundation

class CounterModel: ObservableObject {
    @Published var ballCounter = 0
    @Published var ballMax = 50
}
