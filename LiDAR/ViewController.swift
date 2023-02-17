//
//  ViewController.swift
//  LiDAR
//
//  Created by Apiphoom Chuenchompoo on 12/2/2566 BE.
//
import Foundation
import RealityKit
import ARKit
import ModelIO
import MetalKit
import QuickLook


class ViewController: UIViewController, ARSessionDelegate {
 
    
    
    private let session = ARSession()
    var rederer: Renderer!
    
    @IBOutlet var MetalKitView: MTKView!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var planeDetectionButton: UIButton!
    @IBOutlet weak var saveButton: RoundedButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let device = MTLCreateSystemDefaultDevice() else {
            print("Metal is not supported on this device")
            return
        }
        
        session.delegate = self
        MetalKitView.device = device
        MetalKitView.backgroundColor = .clear
        MetalKitView.depthStencilPixelFormat = .depth32Float
        MetalKitView.contentScaleFactor = 1
        MetalKitView.delegate = self
        
    }
 
    
    @IBAction func resetButtonPressed(_ sender: Any) {
     
    }
    
    
    @IBAction func togglePlaneDetectionButtonPressed(_ button: UIButton) {
 
    }
    

    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
      
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
   
    }
    
}
extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        rederer.drawRectResized(size: size)
    }
    
    func draw(in view: MTKView) {
        rederer.draw()
    }
}
