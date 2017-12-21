//
//  TextButtonNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class TextButtonNode: SKNode {

    override var frame: CGRect {
        return backgroundNode.frame.positioned(anchorType: .center, at: position)
    }

    let label: TextLabelNode
    let backgroundNode: SKSpriteNode

    required init(text: String, fontSize: FontSize) {

        label = TextLabelNode(text: text, fontSize: fontSize)
        label.verticalAlignmentMode = .center
        label.zPosition = 500

        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "WoodenBoard"))
        backgroundNode.zPosition = 0
        backgroundNode.size = RunSceneConstants.Size.button

        super.init()

        addChildren([label, backgroundNode])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
