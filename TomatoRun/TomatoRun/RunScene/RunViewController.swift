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
import GoogleMobileAds

class RunViewController: UIViewController {

    var gameStateMachine: GameStateMachine!

    var reviveRewarded: Bool = false

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

    func playerDied() {
        if gameStateMachine.revived == true {
            presentGameOverScene()
        } else {
            presentReviveScene()
        }
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

    func startGame() {
        presentRunScene(gameStateMachine: GameStateMachine(initialScore: 0, revived: false))
    }

    func presentRunScene(gameStateMachine: GameStateMachine) {

        self.gameStateMachine = gameStateMachine

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

// MARK: - Video
extension RunViewController: GADRewardBasedVideoAdDelegate {

    func rewardBasedVideoAd(_: GADRewardBasedVideoAd, didRewardUserWith _: GADAdReward) {
        GADRewardBasedVideoAd.sharedInstance().delegate = nil
        let alert = UIAlertController(title: "Vid Debug", message: "Was rewarded", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.reviveRewarded = true
        }
        alert.addAction(action)
        present(alert, animated: true) {}
    }

    func rewardBasedVideoAdDidClose(_: GADRewardBasedVideoAd) {
        GADRewardBasedVideoAd.sharedInstance().load(GADRequest(), withAdUnitID: GoogleAdsConstants.AdUnitId.reviveAd)

        if reviveRewarded == true {
            reviveRewarded = false

            gameStateMachine.getFinalScore({ score in
                presentRunScene(gameStateMachine: GameStateMachine(initialScore: score, revived: true))
            })
        }
    }

    func rewardBasedVideoAdDidReceive(_: GADRewardBasedVideoAd) {
        let alert = UIAlertController(title: "Vid Debug", message: "Got video", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {

                let alert = UIAlertController(title: "Vid Debug", message: "It's ready", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                    GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
                }

                alert.addAction(action)
                self.present(alert, animated: true) {}
            } else {
                let alert = UIAlertController(title: "Vid Debug", message: "It's not ready", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                }

                alert.addAction(action)
                self.present(alert, animated: true, completion: {
                })
            }
        }

        alert.addAction(action)
        present(alert, animated: true) {
        }
    }

    func presentRewardAd() {
        GADRewardBasedVideoAd.sharedInstance().delegate = self
        let alert = UIAlertController(title: "Vid Debug", message: "Told to present video", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { _ in
            if GADRewardBasedVideoAd.sharedInstance().isReady == true {

                let alert = UIAlertController(title: "Vid Debug", message: "It's ready", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                    GADRewardBasedVideoAd.sharedInstance().present(fromRootViewController: self)
                }

                alert.addAction(action)
                self.present(alert, animated: true) {}
            } else {
                let alert = UIAlertController(title: "Vid Debug", message: "It's not ready", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel) { _ in
                }

                alert.addAction(action)
                self.present(alert, animated: true, completion: {
                })
            }
        }
        alert.addAction(action)
        present(alert, animated: true) {}
    }
}
