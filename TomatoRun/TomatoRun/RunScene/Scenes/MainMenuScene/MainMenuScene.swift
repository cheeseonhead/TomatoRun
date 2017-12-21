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
    var highscoreButton: TextButtonNode!

    override func didMove(to _: SKView) {
        playButton = TextButtonNode(text: "Play", fontSize: .Large)
        highscoreButton = TextButtonNode(text: "Scores", fontSize: .Large)

        layoutNodes()

        addChild(playButton)
        addChild(highscoreButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchedNodes = getTouchedChildren(touch, with: event)

        if touchedNodes.contains(playButton) {
            startGame()
        } else if touchedNodes.contains(highscoreButton) {
            showHighscore()
        }
    }

    func startGame() {
        runViewController?.startGame()
    }

    func showHighscore() {
        runViewController?.presentLeaderboard()
    }

    func layoutNodes() {
        playButton.layoutUsing(CGRect.centered(at: frame))

        let buttonLayout = CGRect.belowCentered(playButton.frame) >== CGRect.offsetted(by: CGVector(dx: 0, dy: -RunSceneConstants.Spacing.MainMenu.button))

        highscoreButton.layoutUsing(buttonLayout)
    }
}
