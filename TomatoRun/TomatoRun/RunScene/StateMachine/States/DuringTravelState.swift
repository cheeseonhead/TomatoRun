//
//  DuringTravelState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class DuringTravelState: GKState {
    var moveState: MoveState!

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == WanderingState.self
    }

    override func willExit(to _: GKState) {
        moveState.targetIntersection.canBreak = true
    }
}
