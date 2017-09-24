//
//  TravelToStartState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class TravelToStartState: GKState {
    weak var targetIntersectionComponent: IntersectionComponent?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == IdleOnStartState.self ||
            stateClass == WanderingState.self
    }
}
