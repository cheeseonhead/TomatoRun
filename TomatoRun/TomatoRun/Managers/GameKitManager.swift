//
//  GameKitManager.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/6/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameKit

class GameKitManager: NSObject {

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
}