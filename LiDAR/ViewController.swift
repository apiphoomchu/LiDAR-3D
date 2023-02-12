//
//  ViewController.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 12/2/2566 BE.
//

import RealityKit
import ARKit

class ViewController: UIViewController, ARSessionDelegate {
    
    @IBOutlet weak var arView: ARView!
    
    var orientation: UIInterfaceOrientation {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
            fatalError("Fatal Error : Can't resolve an issue")
        }
        return orientation
    }
    
    lazy var imageViewSize: CGSize = {
        CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func setARViewOptions(){
            arView.debugOptions.insert(.showSceneUnderstanding)
        }
        
        func buildConfigure() -> ARWorldTrackingConfiguration{
            let configuration = ARWorldTrackingConfiguration()
            configuration.environmentTexturing = .automatic
            configuration.sceneReconstruction = .mesh
            
            if type(of: configuration).supportsFrameSemantics(.sceneDepth) {
                configuration.frameSemantics = .sceneDepth
            }
            
            return configuration
            
        }
        
        func initARView(){
            setARViewOptions()
            let configuration = buildConfigure()
            arView.session.run(configuration)
        }
        
        arView.session.delegate = self
        super.viewDidLoad()
        initARView()
        
    }
}

