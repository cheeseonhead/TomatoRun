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
        return backgroundNode.frame
    }

    let label: SKLabelNode
    let backgroundNode: SKSpriteNode
    var inset: UIEdgeInsets {
        didSet {
            backgroundNode.size = label.frame.size.addedInsets(inset)
        }
    }

    required init(text: String, fontSize: FontSize) {

        label = SKLabelNode(text: text)
        label.fontSize = fontSize.rawValue
        label.verticalAlignmentMode = .center
        label.zPosition = 500

        inset = UIEdgeInsets(inset: RunSceneConstants.Padding.buttonInside)

        backgroundNode = SKSpriteNode(texture: SKTexture(imageNamed: "WoodenBoard"))
        backgroundNode.zPosition = 0

        super.init()

        addChildren([label, backgroundNode])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
