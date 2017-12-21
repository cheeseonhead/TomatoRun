//
//  GamePlayingState.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-20.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class GamePlayingState: GKState {

    let initialScore: Int

    required init(initialScore: Int) {
        self.initialScore = initialScore
        super.init()
    }

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == GamePausedState.self ||
            stateClass == GameOverState.self
    }
}
