//
//  ScoreComponent.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/13/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class ScoreComponent: GKComponent {
    var score = 0
    var lastTimestamp: TimeInterval?

    required override init() {
        super.init()
    }

    convenience init(initialScore: Int) {
        self.init()

        score = initialScore
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        if lastTimestamp == nil {
            lastTimestamp = seconds
            return
        }

        let addScore = (seconds * RunSceneConstants.scoreRate).roundedToInt(.toNearestOrAwayFromZero)
        score += addScore
    }
}
