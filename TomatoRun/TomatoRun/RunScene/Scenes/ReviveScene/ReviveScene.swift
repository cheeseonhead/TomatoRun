//
//  ReviveScene.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 12/20/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class ReviveScene: SKScene, RunPresentable {

    var runViewController: RunViewController?
    var gameStateMachine: GameStateMachine!

    var scoreLabel: ScoreLabelNode!
    var watchVideoButton: TextButtonNode!
    var cancelButton: TextButtonNode!

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        scoreLabel = ScoreLabelNode(score: 0)
        gameStateMachine?.getFinalScore { score in
            scoreLabel.score = score
        }

        watchVideoButton = TextButtonNode(text: "WATCH VID", fontSize: .Large)

        layoutNodes()

        addChildren([scoreLabel, watchVideoButton])
    }
}

private extension ReviveScene {
    func layoutNodes() {
        scoreLabel.layoutUsing(CGRect.positioned(anchorType: .center, at: CGPoint.zero))
        let buttonLayout = CGRect.belowCentered(scoreLabel.frame) >== CGRect.offsetted(by: CGVector(dx: 0, dy: -60))
        watchVideoButton.layoutUsing(buttonLayout)
    }
}
