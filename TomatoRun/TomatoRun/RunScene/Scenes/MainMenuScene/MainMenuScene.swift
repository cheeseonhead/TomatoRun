//
//  MainMenuScene.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class MainMenuScene: SKScene, RunPresentable {

    weak var runViewController: RunViewController?
    var gameStateMachine: GameStateMachine!

    var playButton: TextButtonNode!

    override func didMove(to _: SKView) {
        playButton = TextButtonNode(text: "Play", fontSize: .Large)

        addChild(playButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchedNodes = getTouchedChildren(touch, with: event)

        if touchedNodes.contains(playButton) {
            startGame()
        }
    }

    func startGame() {
        runViewController?.presentRunScene()
    }
}
