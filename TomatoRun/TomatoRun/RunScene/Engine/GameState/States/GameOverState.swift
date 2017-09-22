//
//  GameOverState.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-20.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class GameOverState: GKState {
    var finalScore: Int?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == GamePlayingState.self
    }
}
