//
//  SKAction+Run.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/24/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKNode {
    func run(_ action: SKAction, withKey key: String, completion: () -> Void) {

        let finalAction = SKAction.run {
            completion()
        }
        let sequence = SKAction.sequence([action, completion])

        run(action, withKey: key)
    }
}
