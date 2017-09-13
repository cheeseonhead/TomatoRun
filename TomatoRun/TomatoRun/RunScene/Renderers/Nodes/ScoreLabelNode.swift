//
//  ScoreLabelNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/13/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class ScoreLabelNode: SKLabelNode {
    override init() {
        super.init(fontNamed: "Helvetica")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
