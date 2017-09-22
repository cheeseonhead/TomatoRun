//
//  Presenting.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-22.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

protocol Presenting {
    func presentScene<SceneType: SKScene>(fileNamed name: String, getSKScene: (GKScene) -> SceneType?)
}

extension SKScene: Presenting {
    func presentScene<SceneType: SKScene>(fileNamed name: String, getSKScene: (GKScene) -> SceneType?) {
        if let scene = GKScene(fileNamed: name) {

            // Get the SKScene from the loaded GKScene
            if let sceneNode = getSKScene(scene) {
                // Set the scale mode to scale to fit the window
                sceneNode.scaleMode = .aspectFill

                view?.presentScene(sceneNode)
            }
        }
    }
}
