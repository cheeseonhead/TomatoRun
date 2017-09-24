//
//  MainMenuScene.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class MainMenuScene: SKScene {
    var playButton: TextButtonNode!

    override func didMove(to _: SKView) {
        playButton = TextButtonNode(text: "Play", fontSize: .Large, size: CGSize(width: 200, height: 100))

        addChild(playButton)
    }
}
