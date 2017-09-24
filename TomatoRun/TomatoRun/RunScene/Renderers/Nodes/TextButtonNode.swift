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

    required init(text: String, fontSize: FontSize) {

        label = SKLabelNode(text: text)
        label.fontSize = fontSize.rawValue
        label.verticalAlignmentMode = .center
        label.zPosition = 500

        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "WoodenBoard"), color: .red,
                                      size: label.frame.size.addedPadding(RunSceneConstants.Padding.ButtonInside))
        backgroundNode.zPosition = 0

        super.init()

        addChildren([label, backgroundNode])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
