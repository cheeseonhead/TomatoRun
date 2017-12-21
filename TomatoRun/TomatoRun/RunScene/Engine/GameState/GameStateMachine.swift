//
//  GameStateMachine.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-19.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class GameStateMachine: GKStateMachine {
    let initialScore: Int

    init(initialScore: Int) {
        self.initialScore = initialScore
        super.init(states: [
            GamePlayingState(),
            GamePausedState(),
            GameOverState(),
        ])

        enter(GamePlayingState.self)
    }

    func getFinalScore(_ callback: (Int) -> Void) {
        if let gameOverState = currentState as? GameOverState,
            let score = gameOverState.finalScore {
            callback(score)
        }
    }
}
