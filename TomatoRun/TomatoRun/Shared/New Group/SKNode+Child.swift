//
//  SKNode+Child.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKNode {
    func addChildren(_ nodes: [SKNode]) {
        for node in nodes {
            addChild(node)
        }
    }
}
