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

protocol RunPresentable {
    weak var runViewController: RunViewController? { get set }
    var gameStateMachine: GameStateMachine! { get set }
}

class RunViewController: UIViewController {

    var gameStateMachine: GameStateMachine!

    override func viewDidLoad() {
        super.viewDidLoad()

        gameStateMachine = GameStateMachine()

        presentMainMenuScene()
    }

    func presentMainMenuScene() {
        presentScene(fileNamed: "MainMenuScene", getSKScene: { gkScene -> MainMenuScene? in gkScene.rootNode as? MainMenuScene })
    }

    func presentGameOverScene() {
        presentScene(fileNamed: "GameOverScene", getSKScene: { gkScene -> GameOverScene? in gkScene.rootNode as? GameOverScene })
    }

    func presentRunScene() {
        presentScene(fileNamed: "RunScene") { gkScene -> RunScene? in
            guard let runScene = gkScene.rootNode as? RunScene else { return nil }

            runScene.gameStateMachine = gameStateMachine
            runScene.entities = gkScene.entities
            runScene.graphs = gkScene.graphs

            return runScene
        }
    }

    func presentScene<SceneType: SKScene & RunPresentable>(fileNamed name: String, getSKScene: (GKScene) -> SceneType?) {
        if let scene = GKScene(fileNamed: name) {

            // Get the SKScene from the loaded GKScene
            if var sceneNode = getSKScene(scene) {
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill
                sceneNode.runViewController = self
                sceneNode.gameStateMachine = gameStateMachine

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
