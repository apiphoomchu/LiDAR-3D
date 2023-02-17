//
//  SCNNode.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 17/2/2566 BE.
//

import Foundation
import SceneKit

extension SCNNode {
    func cleanup() {
        for child in childNodes {
            child.cleanup()
        }
        self.geometry = nil
    }
}
