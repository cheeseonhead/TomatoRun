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

    var gameStateMachine: GameStateMachine!

    override func viewDidLoad() {
        super.viewDidLoad()

        presentMainMenuScene()
    }
}

// MARK: - View controllers
extension RunViewController {

    func presentLeaderboard() {
        guard let gameCenterVC = GameKitManager.shared.gameCenterViewController() else { return }

        present(gameCenterVC, animated: true, completion: nil)
    }
}

// MARK: - Scenes
extension RunViewController {

    func presentMainMenuScene() {
        presentScene(fileNamed: "MainMenuScene", getSKScene: { gkScene -> MainMenuScene? in gkScene.rootNode as? MainMenuScene })
    }

    func presentReviveScene() {
        presentScene(fileNamed: "ReviveScene", getSKScene: { gkScene -> ReviveScene? in gkScene.rootNode as? ReviveScene })
    }

    func presentGameOverScene() {
        gameStateMachine.getFinalScore { score in
            GameKitManager.shared.submitScore(score)
        }
        presentScene(fileNamed: "GameOverScene", getSKScene: { gkScene -> GameOverScene? in gkScene.rootNode as? GameOverScene })
    }

    func presentRunScene() {

        gameStateMachine = GameStateMachine(initialScore: 0)

        presentScene(fileNamed: "RunScene") { gkScene -> RunScene? in
            guard let runScene = gkScene.rootNode as? RunScene else { return nil }

            runScene.builder = RunSceneBuilder(gameStateMachine: gameStateMachine, entities: gkScene.entities, graphs: gkScene.graphs)

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
