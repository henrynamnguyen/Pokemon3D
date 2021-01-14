import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        sceneView.autoenablesDefaultLighting = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        //Incoporate the images to the project
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 2
        }
       
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height) //This is going to look at the image it detected and try to measure the physical sizes of the image
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1, alpha: 0.5)
            
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -Float.pi/2 //rotate the plane 90 degree anti-clockwise to make it horizontal
            node.addChildNode(planeNode)
            
            if imageAnchor.referenceImage.name == "eevee.scn" {
            
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    pokeNode.eulerAngles.x = Float.pi/2
                    planeNode.addChildNode(pokeNode)
                }
                
                }
            }
            
            if imageAnchor.referenceImage.name == "oddish.scn" {
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                if let pokeNode = pokeScene.rootNode.childNodes.first {
                    pokeNode.eulerAngles.x = Float.pi/2
                    planeNode.addChildNode(pokeNode)
                }
                
                }
            }
            
        }
        
        return node
    }
   
}
