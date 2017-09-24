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
        if target != nil {
            return stateClass == IdleOnStartState.self ||
                stateClass == StartFoundState.self
        }

        return stateClass == WanderingState.self
    }
}
