//
//  GameOverScene.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-22.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {

    weak var gameStateMachine: GameStateMachine?

    var scoreLabel: ScoreLabelNode!

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        scoreLabel = ScoreLabelNode(score: 0)
        if let gameOverState = gameStateMachine?.currentState as? GameOverState,
            let score = gameOverState.finalScore {
            scoreLabel.score = score
        }

        scoreLabel.position = CGPoint.zero
        addChild(scoreLabel)
    }
}
