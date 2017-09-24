//
//  MoveStateMachine.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

struct Target {
    let startPoint: CGPoint
    let targetIntersection: IntersectionComponent
}

class MoveStateMachine: GKStateMachine {
    init() {
        super.init(states: [
            IdleOnStartState(),
            WanderingState(),
            TravelToStartState(),
            DuringTravelState(),
        ])

        enter(WanderingState.self)
    }
}
