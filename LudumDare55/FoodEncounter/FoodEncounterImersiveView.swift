import SwiftUI
import RealityKit
import RealityKitContent

struct FoodEncounterImmersiveView: View {
    
    // MARK: - Properties
    
    @State private var cubeList: [Entity] = []
    @EnvironmentObject private var viewModel: FoodEncounterView.ViewModel
    
    // ViewModel instance to handle business logic of food
    private var foodModel = FoodViewModel()
    
    // MARK: - Body
    
    var body: some View {
        // RealityView to display augmented reality content
        RealityView { content in
            // Add immersive scene to the content
            if let scene = try? await Entity(named: "ImmersiveScene", in: realityKitContentBundle) {
                content.add(scene)
            }
            
            // Add content entities and food
            content.add(foodModel.setupContentEntity())
            
            // Add food  based on foodMax
            for index in 0..<viewModel.foodMax {
                cubeList.append(Entity())
                cubeList[index] = foodModel.addFood(name: "Food\(index + 1)")
            }
        }
        // Add tap gesture to interact with entities
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    if foodModel.removeModel(entity: value.entity) {
                        correct()
                    }
                }
        )
    }
    
    // MARK: - Helper Function
    
    // Increments the ball counter when a correct cube is removed.
    private func correct() {
        viewModel.foodCounter += 1
    }
}

#Preview {
    FoodEncounterImmersiveView()
        .previewLayout(.sizeThatFits)
}
