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
                cubeList[index] = foodModel.addBurger(name: "Potato\(index + 1)")
            }
            
            for index in 0..<50 {
                cubeList.append(Entity())
                cubeList[index] = foodModel.addTomato(name: "Tomato\(index + 1)")
            }
        }
        // Add tap gesture to interact with entities
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    print(value.entity.name)
                    if value.entity.name.hasPrefix("Object_0") {
                        incorrect()
                    } else {
                        correct()
                    }
                    foodModel.removeModel(entity: value.entity)
                    
                }
        )
    }
    
    // MARK: - Helper Function
    
    // Increments the ball counter when a correct cube is removed.
    private func correct() {
        viewModel.foodCounter += 1
    }
    
    private func incorrect() {
        if viewModel.life > 1 {
            viewModel.life -= 1
        } else {
            viewModel.loseGame()
        }
    }
}

#Preview {
    FoodEncounterImmersiveView()
        .previewLayout(.sizeThatFits)
}
