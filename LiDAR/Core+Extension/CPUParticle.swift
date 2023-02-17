//
//  CPUParticle.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 17/2/2566 BE.
//


import Foundation
import SceneKit

final class CPUParticle {
    var position: simd_float3
    var color: simd_float3
    var confidence: Float
    
    init(position: simd_float3, color: simd_float3, confidence: Float) {
        self.position = position
        self.color = color * 255
        self.confidence = confidence
    }
}

