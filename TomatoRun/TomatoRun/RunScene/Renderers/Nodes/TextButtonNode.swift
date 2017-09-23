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

    init(text: Stringk, size: CGSize) {
        super.init()

        label = SKLabelNode(text: text)
        label.zPosition = 500
        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "WoodenBoard"), color: .red, size: size)
        label.zPosition = 0

        addChildren([label, backgroundNode])
    }

    override init() {
        self.init(text: "")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
