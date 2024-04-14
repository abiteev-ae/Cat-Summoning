//
//  PortalView.swift
//  LudumDare55
//
//  Created by Ilia Proskuriakov on 14.04.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct PortalView : View {
    var body: some View {
        RealityView { content in
            let world = makeWorld()
            let portal = makePortal(world: world)
            let manul = makeManul()
            
            let anchor = AnchorEntity(.plane(.vertical, classification: .wall, minimumBounds: [1, 1]))
            content.add(anchor)

            let anchorPortal = AnchorEntity(.world(transform: portal.transform.matrix))
            content.add(anchorPortal)
            content.add(world)
            content.add(portal)
            content.add(manul)
            let radians = 90.0 * Float.pi / 180.0
            portal.orientation = simd_quatf(angle: radians, axis: SIMD3(x: -1, y: 0, z: 0))
            anchor.addChild(portal)
            anchor.addChild(world)
            anchorPortal.addChild(manul)
        }
    }
}

public func makeManul() -> Entity {
    let entity = try! Entity.load(named: "pallasCat.usdz", in: realityKitContentBundle)
    print("Found scene named: \(entity.name)")
    print("Found scene named: \(entity.debugDescription)")
    entity.scale = SIMD3(x: 0.015, y: 0.015, z: 0.015)
    let radians = Float.pi / 2
    let xRotation = simd_quatf(angle: .pi * 3/2, axis: simd_float3(1, 0, 0))
    entity.orientation = xRotation
    entity.scale = SIMD3(x: 0.05, y: 0.05, z: 0.05)
    return entity
}

public func makeWorld() -> Entity {
    let world = Entity()
    world.components[WorldComponent.self] = .init()
//    let envirenment = try! EnvironmentResource.load(named: "Sun", in: realityKitContentBundle)
//    world.components[ImageBasedLightComponent.self] = .init(source: .single(envirenment), intensityExponent: 6)
    world.components[ImageBasedLightReceiverComponent.self] = .init(imageBasedLight: world)

    let earth = try! Entity.load(named: "Immersive", in: realityKitContentBundle)
//    let sky = try! Entity.load(named: "OuterSpace")
    world.addChild(earth)
//    world.addChild(sky)

    return world
}

public func makePortal(world: Entity) -> Entity {
    let portal = Entity()
    let emitters = try! Entity.load(named: "Particle", in: realityKitContentBundle)
    emitters.scale = SIMD3(x: 1, y: 1, z: 1)
    portal.components[ModelComponent.self] = .init(mesh: .generatePlane(width: 1,
                                                                        height: 1,
                                                                        cornerRadius: 0.5),
                                                   materials: [PortalMaterial()])
    portal.components[PortalComponent.self] = .init(target: world)
    portal.addChild(emitters)

    return portal
}

func particleSystem() -> ParticleEmitterComponent {
    var particles = ParticleEmitterComponent()
    particles.timing = .repeating(warmUp: 0, emit: ParticleEmitterComponent.Timing.VariableDuration(duration: 0.2), idle: ParticleEmitterComponent.Timing.VariableDuration(duration: 0))
    particles.emitterShape = .torus
    particles.torusInnerRadius = 0.05
    particles.spawnOccasion = .onBirth
    particles.birthLocation = .surface
    particles.emitterShapeSize = [1, 1, 0] // meter
    particles.emissionDirection = [0, 1, 0]
    particles.mainEmitter.birthRate = 5000
    particles.mainEmitter.size = 0.03 // meter
    particles.mainEmitter.acceleration = [0, -3, 0]
    particles.mainEmitter.lifeSpan = 0.4
    particles.mainEmitter.mass = 1
    particles.mainEmitter.color = .evolving(start: .single(.white),
                                            end: .single(.blue) )
    particles.mainEmitter.spreadingAngle = 0.2
    // particles.burst()
    return particles
}

#Preview {
    PortalView()
        .previewLayout(.sizeThatFits)
}
