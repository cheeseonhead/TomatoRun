//
//  TextButtonNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class TextButtonNode: SKNode {

    let label: SKLabelNode
    let backgroundNode: SKSpriteNode

    required init(text: String, size: CGSize) {

        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "WoodenBoard"), color: .red, size: size)
        backgroundNode.zPosition = 0

        label = SKLabelNode(text: text)
        label.zPosition = 500

        super.init()

        addChildren([label, backgroundNode])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
