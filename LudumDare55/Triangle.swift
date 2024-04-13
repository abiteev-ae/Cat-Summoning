//
//  File.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 14.04.2024.
//
import ARKit
import simd

struct Triangle {
    var positions: [SIMD3<Float>]

//    func isColliding(with other: Triangle) -> Bool {
//        // Implement Separating Axis Theorem (SAT) for triangle-triangle collision detection
//        // using Minkowski difference
//
//        func edge(a: SIMD3<Float>, b: SIMD3<Float>) -> SIMD3<Float> {
//            return b - a
//        }
//
//        func normal(edge: SIMD3<Float>) -> SIMD3<Float> {
//            let lengthSquared = simd_dot(edge, edge)
//            let inverseLength = simd_rsqrt(lengthSquared)
//            return simd_normalize(edge)
//        }
//
//        func dot(a: SIMD3<Float>, b: SIMD3<Float>) -> Float {
//            return simd_dot(a, b)
//        }
//
//        func project(point: SIMD3<Float>, axis: SIMD3<Float>) -> Float {
//            return dot(a: point, b: axis)
//        }
//
//        func projectTriangle(triangle: [SIMD3<Float>], axis: SIMD3<Float>) -> (min: Float, max: Float) {
//            var minProjection = project(point: triangle[0], axis: axis)
//            var maxProjection = minProjection
//
//            for i in 1..<triangle.count {
//                let projection = project(point: triangle[i], axis: axis)
//                if projection < minProjection {
//                    minProjection = projection
//                } else if projection > maxProjection {
//                    maxProjection = projection
//                }
//            }
//
//            return (min: minProjection, max: maxProjection)
//        }
//
//        let edges = [
//            edge(a: self.positions[0], b: self.positions[1]),
//            edge(a: self.positions[1], b: self.positions[2]),
//            edge(a: self.positions[2], b: self.positions[0])
//        ]
//
//        let otherEdges = [
//            edge(a: other.positions[0], b: other.positions[1]),
//            edge(a: other.positions[1], b: other.positions[2]),
//            edge(a: other.positions[2], b: other.positions[0])
//        ]
//
//        let normals = edges.map(normal) + otherEdges.map { normal(edge: -$0) }
//
//        for axis in normals {
//            let projection1 = projectTriangle(triangle: self.positions, axis: axis)
//            let projection2 = projectTriangle(triangle: other.positions, axis: axis)
//
//            if projection1.max < projection2.min || projection1.min > projection2.max {
//                return false
//            }
//        }
//
//        return true
//    }

}
