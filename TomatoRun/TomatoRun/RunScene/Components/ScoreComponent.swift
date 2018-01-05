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
    var startYPosition: Double?

    let initialScore: Int

    required init(initialScore: Int) {

        self.initialScore = initialScore

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime _: TimeInterval) {

        guard let positionalEntity = entity as? Positional else {
            return
        }

        let curY = Double(positionalEntity.getPosition().y)

        if startYPosition == nil {
            startYPosition = curY
            return
        }

        guard let startYPosition = startYPosition else { return }

        score = initialScore + ((curY - startYPosition) * RunSceneConstants.scoreRate).roundedToInt(.toNearestOrAwayFromZero)
    }
}
