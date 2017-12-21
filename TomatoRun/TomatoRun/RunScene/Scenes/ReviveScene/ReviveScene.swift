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
        cancelButton = TextButtonNode(text: "Cancel", fontSize: .Large)

        layoutNodes()

        addChildren([scoreLabel, watchVideoButton, cancelButton])
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchedNodes = getTouchedChildren(touch, with: event)

        if touchedNodes.contains(watchVideoButton) {
            runViewController?.presentRewardAd()
        } else if touchedNodes.contains(cancelButton) {
            runViewController?.presentGameOverScene()
        }
    }
}

private extension ReviveScene {
    func layoutNodes() {
        scoreLabel.layoutUsing(CGRect.positioned(anchorType: .center, at: CGPoint.zero))

        var buttonLayout = CGRect.belowCentered(scoreLabel.frame) >== CGRect.offsetted(by: CGVector(dx: 0, dy: -60))
        watchVideoButton.layoutUsing(buttonLayout)

        buttonLayout = CGRect.belowCentered(watchVideoButton.frame) >== CGRect.offsetted(by: CGVector(dx: 0, dy: -40))
        cancelButton.layoutUsing(buttonLayout)
    }
}
