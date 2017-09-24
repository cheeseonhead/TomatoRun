//
//  IdleOnStartState.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-07.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class IdleOnStartState: GKState {
    var target: Target?

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == DuringTravelState.self
    }

    override func willExit(to nextState: GKState) {
        guard let duringTravel = nextState as? DuringTravelState else { return }

        duringTravel.target = target

        target = nil
    }
}
