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
    var mainMenuButton: TextButtonNode!

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        scoreLabel = ScoreLabelNode(score: 0)
        gameStateMachine?.getFinalScore { score in
            scoreLabel.score = score
        }

        mainMenuButton = TextButtonNode(text: "MENU", fontSize: .Large)

        layoutNodes()

        addChildren([scoreLabel, mainMenuButton])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchedChildren = getTouchedChildren(touch, with: event)

        _ = touchedChildren.map { (node) -> Void in
            if node == mainMenuButton {
                runViewController?.presentMainMenuScene()
            }
        }
    }
}

private extension GameOverScene {
    func layoutNodes() {
        scoreLabel.layoutUsing(CGRect.positioned(anchorType: .center, at: CGPoint.zero))
        let buttonLayout = CGRect.belowCentered(scoreLabel.frame) >== CGRect.offsetted(by: CGVector(dx: 0, dy: -60))
        mainMenuButton.layoutUsing(buttonLayout)
    }
}
