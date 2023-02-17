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
    var renderer: Renderer!
    
    @IBOutlet var MetalKitView: MTKView!
    @IBOutlet weak var StartDetectionButton: RoundedButton!
    
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
        
        renderer = Renderer(session: session, metalDevice: device, renderDestination: MetalKitView!)
        renderer.drawRectResized(size: MetalKitView.bounds.size)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.frameSemantics = [.sceneDepth, .smoothedSceneDepth]
        session.run(configuration)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    
    @IBAction func resetButtonPressed(_ sender: Any) {
        renderer.isInViewSceneMode = true
        renderer.clearParticles()
    }
    
    
    @IBAction func togglePlaneDetectionButtonPressed(_ button: UIButton) {
        renderer.isInViewSceneMode = !renderer.isInViewSceneMode
        if !renderer.isInViewSceneMode {
            renderer.showParticles = true
            StartDetectionButton.backgroundColor = .red
            StartDetectionButton.setTitleColor(.white, for: .normal)
            StartDetectionButton.setTitle("Stop Point Cloud", for: .normal)
        } else {
            StartDetectionButton.backgroundColor = .white
            StartDetectionButton.setTitleColor(.black, for: .normal)
            StartDetectionButton.setTitle("Start Point Cloud", for: .normal)
        }
        
    }
    
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        
        
    }
    
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }
        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "The AR session failed.", message: errorMessage, preferredStyle: .alert)
            let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
                alertController.dismiss(animated: true, completion: nil)
                if let configuration = self.session.configuration {
                    self.session.run(configuration, options: .resetSceneReconstruction)
                }
            }
            alertController.addAction(restartAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
extension ViewController: MTKViewDelegate {
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        guard session.currentFrame != nil else {return}
        renderer.drawRectResized(size: size)
        
    }
    
    func draw(in view: MTKView) {
        renderer.draw()
    }
}

extension MTKView: RenderDestinationProvider {}
