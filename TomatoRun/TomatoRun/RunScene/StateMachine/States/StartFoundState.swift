//
//  StartFoundState.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/24/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class StartFoundState: MoveMachineState {

    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass == TravelingToStartState.self
    }
}
