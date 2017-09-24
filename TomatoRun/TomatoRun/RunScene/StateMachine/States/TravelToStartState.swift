//
//  TravelToStartState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class TravelToStartState: GKState {
    var moveState: Target?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == IdleOnStartState.self {
            return moveState != nil
        }

        return stateClass == WanderingState.self
    }

    override func willExit(to nextState: GKState) {
        guard let idleOnStart = nextState as? IdleOnStartState,
            let moveState = moveState else { return }

        moveState.targetIntersection.canBreak = false
        idleOnStart.moveState = moveState
    }
}
