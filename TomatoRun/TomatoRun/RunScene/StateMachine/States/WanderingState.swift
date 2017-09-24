//
//  WanderingState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class WanderingState: GKState {
    var target: Target?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == StartFoundState.self {
            return target != nil
        }
        return nil
    }

    override func willExit(to nextState: GKState) {
        if let nextState = nextState as? StartFoundState {
            nextState.target = target
        }
    }
}
