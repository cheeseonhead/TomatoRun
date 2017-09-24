//
//  WanderingState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class WanderingState: GKState {
    var moveState: MoveState?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        if stateClass == TravelToStartState.self {
            return moveState == nil
        }
        return false
    }

    override func willExit(to nextState: GKState) {
        if let travelToStart = nextState as? TravelToStartState {
            travelToStart.moveState = moveState
        }
    }
}
