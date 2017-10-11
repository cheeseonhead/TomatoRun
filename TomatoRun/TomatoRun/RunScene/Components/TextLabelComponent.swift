//
//  TextLabelComponent.swift
//  TomatoRun
//
//  Created by Andy Sheng on 2017-09-29.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class TextLabelComponent: GKComponent {

    let anchor: CGPoint
    let node: SKLabelNode

    init(text: String, anchor: CGPoint) {
        node = SKLabelNode(text: text)
        self.anchor = anchor

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didAddToEntity() {
        super.didAddToEntity()
        node.entity = entity
    }
}
