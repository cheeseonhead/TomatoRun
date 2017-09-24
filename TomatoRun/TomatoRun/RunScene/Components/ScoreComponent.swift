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

    override func update(deltaTime seconds: TimeInterval) {
        if lastTimestamp == nil {
            lastTimestamp = seconds
            return
        }

        let addScore = (seconds * RunSceneConstants.ScoreRate).roundedToInt(.toNearestOrAwayFromZero)
        score += addScore
        print("Score: \(score)")
    }
}
