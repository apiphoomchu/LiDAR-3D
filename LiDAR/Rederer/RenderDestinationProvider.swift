//
//  RenderDestinationProvider.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 17/2/2566 BE.
//

import Metal
import MetalKit

protocol RenderDestinationProvider {
    var currentRenderPassDescriptor: MTLRenderPassDescriptor? { get }
    var currentDrawable: CAMetalDrawable? { get }
    var colorPixelFormat: MTLPixelFormat { get set }
    var depthStencilPixelFormat: MTLPixelFormat { get set }
    var sampleCount: Int { get set }
}
