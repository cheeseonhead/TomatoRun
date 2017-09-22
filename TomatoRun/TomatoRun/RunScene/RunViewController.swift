//
//  GameViewController.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-08.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class RunViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        presentScene(fileNamed: "RunScene") { gkScene in
            guard let runScene = gkScene.rootNode as? RunScene else { return nil }

            runScene.entities = gkScene.entities
            runScene.graphs = gkScene.graphs

            return runScene
        }
    }

    func presentGameOverScene() {
        presentScene(fileNamed: "GameOverScene", getSKScene: { gkScene in gkScene.rootNode as? GameOverScene })
    }

    func presentScene<SceneType: SKScene>(fileNamed name: String, getSKScene: (GKScene) -> SceneType?) {
        if let scene = GKScene(fileNamed: name) {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = getSKScene(scene) {
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill

                // Present the scene
                if let view = self.view as! SKView? {
                    view.presentScene(sceneNode)

                    view.ignoresSiblingOrder = true

                    view.showsFPS = true
                    view.showsNodeCount = true
                }
            }
        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
