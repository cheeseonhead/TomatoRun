//
//  GameOverScene.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-22.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene, RunPresentable {

    weak var runViewController: RunViewController?
    var gameStateMachine: GameStateMachine!

    var scoreLabel: ScoreLabelNode!

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        scoreLabel = ScoreLabelNode(score: 0)
        gameStateMachine?.getFinalScore { score in
            scoreLabel.score = score
        }

        scoreLabel.position(anchorType: .center, at: CGPoint(x: 0, y: 0))
        addChild(scoreLabel)
    }
}
