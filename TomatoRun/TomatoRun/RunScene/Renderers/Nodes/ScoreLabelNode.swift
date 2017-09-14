//
//  ScoreLabelNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/13/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class ScoreLabelNode: SKLabelNode {
    var score: Int? {
        didSet {
            guard let score = score else { return }

            text = formattedScore(score)
        }
    }

    override init() {
        super.init()

        verticalAlignmentMode = .baseline
        horizontalAlignmentMode = .left

        zPosition = RunSceneConstants.ZPositions.UIZPosition
    }

    override init(fontNamed fontName: String?) {
        super.init(fontNamed: fontName)
    }

    convenience init(score: Int?) {
        self.init(fontNamed: "BebasNeueBold")

        fontSize = FontSize.Large.rawValue
        self.score = score
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func formattedScore(_ score: Int) -> String {
        return String(format: "%0\(RunSceneConstants.ScoreLength)d", score)
    }
}
