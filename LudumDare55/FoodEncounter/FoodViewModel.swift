import Foundation
import RealityKit
import RealityKitContent

class FoodViewModel {
    private var contentEntity = Entity()
    func setupContentEntity() -> Entity {
        return contentEntity
    }
    
    func getTargetEntity(name: String) -> Entity? {
        return contentEntity.children.first { $0.name == name }
    }
    
    func addBurger(name: String) -> Entity {
        do {
            let entity = try ModelEntity.load(named: "burger.usdz", in: realityKitContentBundle)
            entity.generateCollisionShapes(recursive: true)
            entity.name = name
            entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            entity.components.set(HoverEffectComponent())
            
            entity.position = getRandomPosition()
            
            contentEntity.addChild(entity)
            
            return entity
        } catch {
            return Entity()
        }
    }
    
    func addTomato(name: String) -> Entity {
        do {
            let entity = try Entity.load(named: "tomato.usdz", in: realityKitContentBundle)
            entity.scale = SIMD3(x: 0.01, y: 0.01, z: 0.01)
            entity.generateCollisionShapes(recursive: true)
            entity.name = name
            entity.components.set(InputTargetComponent(allowedInputTypes: .indirect))
            entity.components.set(HoverEffectComponent())
            
            entity.position = getRandomPosition()
            
            contentEntity.addChild(entity)
            return entity
        } catch {
            return Entity()
        }
    }
    
    
    func removeModel(entity: Entity) {
        entity.removeFromParent()
    }
    
    private func getRandomPosition() -> SIMD3<Float> {
        return SIMD3(
            x: Float.random(in: -10...10),
            y: Float.random(in: -10...10),
            z: Float.random(in: -10...10)
        )
    }
}
