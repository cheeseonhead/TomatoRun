//
//  DuringTravelState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class DuringTravelState: GKState {
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == WanderingState.self
    }
}
