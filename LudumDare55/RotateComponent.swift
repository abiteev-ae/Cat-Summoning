//
//  RotateComponent.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import Foundation
import RealityKit

struct RotateComponent: Component {
    var isCollecting: Bool = false
    var animationProgress: Float  = 0.0

    var startPositionY: Float?
    var endPositionY: Float?
}
