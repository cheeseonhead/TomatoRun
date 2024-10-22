//
//  WanderingState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class MoveMachineState: GKState {
    var target: Target?

    override func willExit(to nextState: GKState) {
        if let state = nextState as? MoveMachineState {
            state.target = target
        }

        target = nil
    }
}

class WanderingState: MoveMachineState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StartFoundState.self {
            return target != nil
        }
        return false
    }
}
