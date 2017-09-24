//
//  TravelToStartState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class TravelingToStartState: MoveMachineState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == IdleOnStartState.self {
            return target != nil
        }

        return stateClass == WanderingState.self
    }

    override func willExit(to nextState: GKState) {
        moveState.targetIntersection.canBreak = false

        super.willExit(to: nextState)
    }
}
