//
//  ImmersiveView.swift
//  Immersive Ball Shooter
//
//  Created by Henry Lam on 29/2/2024.
//
import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {

//    // MARK: - Properties
//    
//    @State private var cubeList: [Entity] = []
//    @EnvironmentObject private var counter: CounterModel
//    
//    // ViewModel instance to handle business logic
//    private var model = BallViewModel()
//
//    // MARK: - Body
//    
//    var body: some View {
//        // RealityView to display augmented reality content
//        RealityView { content in
//            // Add immersive scene to the content
//            if let scene = try? await Entity(named: "ImmersiveScene", in: realityKitContentBundle) {
//                content.add(scene)
//            }
//            
//            // Add content entities and cubes
//            content.add(model.setupContentEntity())
//            
//            // Add green ball cubes based on counter.ballMax
//            for index in 0..<counter.ballMax + 20 {
//                cubeList.append(Entity())
//                cubeList[index] = model.addCube(name: "Cube\(index + 1)", greenball: "true")
//            }
//            
//            // Add additional cubes beyond counter.ballMax
//            for index in counter.ballMax..<300 {
//                cubeList.append(Entity())
//                cubeList[index] = model.addCube(name: "Cube\(index + 1)")
//            }
//        }
//        // Add tap gesture to interact with entities
//        .gesture(
//            SpatialTapGesture()
//                .targetedToAnyEntity()
//                .onEnded { value in
//                    if model.removeModel(entity: value.entity) {
//                        correct()
//                    }
//                }
//        )
//    }
//
//    // MARK: - Helper Function
//    
//    // Increments the ball counter when a correct cube is removed.
//    private func correct() {
//        counter.ballCounter += 1
//    }
//}
//
//#Preview {
//    ImmersiveView()
//        .previewLayout(.sizeThatFits)
//}
    
    @StateObject var realityKitSceneController: SweeperRealityController = SweeperRealityController()

    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        RealityView { content, attachments in
            await realityKitSceneController.firstInit(&content, attachments: attachments, vacuumType: viewModel.vacuumType)
        } update: { content, attachments in
            realityKitSceneController.updateView(&content, attachments: attachments)
        } placeholder: {
            ProgressView()
        } attachments: {
            let _ = print("--attachments")
            Attachment(id: "score") {
                Text("\(realityKitSceneController.score)")
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }
        .gesture(SpatialTapGesture()
            .targetedToAnyEntity()
            .onEnded({ targetValue in
                realityKitSceneController.onTapSpatial(targetValue)
            })
        )
        .onAppear {
            // appear happens before realitykit scene controller init
        }
        .onDisappear {
            realityKitSceneController.cleanup()
        }
    }
}
