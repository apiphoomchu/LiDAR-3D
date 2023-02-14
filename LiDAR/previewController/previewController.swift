//
//  previewController.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 14/2/2566 BE.
//

import UIKit
import SceneKit
import ModelIO
import Insert3D

class previewController: UIViewController{
    
    @IBOutlet weak var modelView: SCNView!
    
    var passObjectURL: URL?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let asset = MDLAsset(url: passObjectURL!)
        let scene = SCNScene()
        let assetNode = SCNNode(mdlObject: asset.object(at: 0))
        scene.rootNode.addChildNode(assetNode)
        
        let ambientLight = SCNLight()
        ambientLight.type = .ambient
        ambientLight.color = UIColor(white: 0.7, alpha: 1.0) // Set the color and intensity of the light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = ambientLight
        scene.rootNode.addChildNode(ambientLightNode)
        
        let directionalLight = SCNLight()
        directionalLight.type = .directional
        directionalLight.color = UIColor(white: 1.0, alpha: 1.0)
        let directionalLightNode = SCNNode()
        directionalLightNode.light = directionalLight
        directionalLightNode.position = SCNVector3(x: 0, y: 0, z: 10) // Position the light in front of the object
        scene.rootNode.addChildNode(directionalLightNode)
        
        
        modelView.allowsCameraControl = true
        modelView.autoenablesDefaultLighting = true
        
        modelView.scene = scene
        modelView.backgroundColor = .systemGray2
        
        
    }
    
    
}
