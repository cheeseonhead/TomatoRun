//
//  Target.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/24/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

struct Target {
    let startPoint: CGPoint
    let targetIntersection: IntersectionComponent
}

extension Target: Equatable {
    static func ==(lhs: Target, rhs: Target) -> Bool {
        return lhs.startPoint == rhs.startPoint
    }
}
