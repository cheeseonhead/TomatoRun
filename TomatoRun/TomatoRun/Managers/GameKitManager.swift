//
//  GameKitManager.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/6/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameKit

class GameKitManager: NSObject, GKGameCenterControllerDelegate {

    static let shared = GameKitManager()

    var authenticationViewController: UIViewController?
    var lastError: Error?

    private var isGameCenterEnabled = true

    func authenticateLocalPlayer() {
        let localPlayer = GKLocalPlayer.localPlayer()

        localPlayer.authenticateHandler = { (_, e) -> Void in
            self.lastError = e

            if GKLocalPlayer.localPlayer().isAuthenticated {
                self.isGameCenterEnabled = true
            } else {
                self.isGameCenterEnabled = false
            }
        }
    }

    func submitScore(_ score: Int) {
        let bestScoreInt = GKScore(leaderboardIdentifier: GameKitConstants.leaderBoardIdentifier)
        bestScoreInt.value = Int64(score)
        GKScore.report([bestScoreInt]) { error in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                print("Best Score submitted to your Leaderboard!")
            }
        }
    }

    func gameCenterViewController() -> UIViewController? {
        if isGameCenterEnabled {
            let gcVC = GKGameCenterViewController()
            gcVC.gameCenterDelegate = self
            gcVC.viewState = .leaderboards
            gcVC.leaderboardIdentifier = GameKitConstants.leaderBoardIdentifier
            return gcVC
        }
        return nil
    }

    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
