//
//  ScoreLabelNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/13/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class ScoreLabelNode: TextLabelNode {
    var score: Int? {
        didSet {
            guard let score = score else { return }

            text = formattedScore(score)
        }
    }

    override init() {
        super.init()
    }

    required init(text: String, fontSize: FontSize) {
        super.init(text: text, fontSize: fontSize)

        verticalAlignmentMode = .baseline
        horizontalAlignmentMode = .left

        zPosition = RunSceneConstants.ZPositions.uiZPosition
    }

    convenience init(score: Int) {
        self.init(text: "", fontSize: .Large)
        self.score = score
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func formattedScore(_ score: Int) -> String {
        return String(format: "%0\(RunSceneConstants.scoreLength)d", score)
    }
}
