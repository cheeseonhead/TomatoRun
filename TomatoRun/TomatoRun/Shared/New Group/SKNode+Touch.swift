//
//  SKNode+Touch.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKNode {
    func getTouchedChildren(_ touch: UITouch, with event: UIEvent?) -> [SKNode] {
        return nodes(at: touch.location(in: self))
    }
}
