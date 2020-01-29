//
//  ViewController.swift
//  SCNTechniqueGlow
//
//  Created by William Perkins on 1/29/20.
//  Copyright © 2020 Laan Labs. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set the view's delegate
        sceneView.delegate = self

        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship2.scn")!

        // Set the scene to the view
        sceneView.scene = scene

        // retrieve the ship node
        let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!

        // animate the ship

        ship.runAction( SCNAction.levitate(distance: 0.03, duration: 2.0) )

        // Set the bitmask to 2 for glow
        //ship.childNodes[0].categoryBitMask = 2
        ship.setHighlighted()


        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path)  {
                let dict2 = dict as! [String : AnyObject]
                let technique = SCNTechnique(dictionary:dict2)

                // set the glow color to yellow
                let color = SCNVector3(1.0, 1.0, 0.0)
                technique?.setValue(NSValue(scnVector3: color), forKeyPath: "glowColorSymbol")

                self.sceneView.technique = technique
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Pause the view's session
        sceneView.session.pause()
    }

}

fileprivate extension SCNAction {
    class func levitate(distance: CGFloat, duration: TimeInterval) -> SCNAction {
        let moveUp = SCNAction.moveBy(x: 0, y: distance/2, z: 0.0, duration: duration/2)
        let moveDown = SCNAction.moveBy(x: 0, y: -distance/2, z: 0.0, duration: duration/2)

        moveUp.timingMode = .easeInEaseOut
        moveDown.timingMode = .easeInEaseOut

        return SCNAction.repeatForever(SCNAction.sequence([moveUp, moveDown]))

    }
}
