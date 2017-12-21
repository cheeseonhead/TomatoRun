//
//  GameStateMachine.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-19.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class GameStateMachine: GKStateMachine {
    init(initialScore: Int) {
        super.init(states: [
            GamePlayingState(initialScore: initialScore),
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

    func getInitialScore(_ callback: (Int) -> Void) {
        if let state = currentState as? GamePlayingState {
            callback(state.initialScore)
        }
    }
}
