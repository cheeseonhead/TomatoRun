//
//  SignNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class SignNode: SKNode {

    let label: TextLabelNode
    let background: SignSpriteNode

    required init(text: String, fontSize: FontSize, backgroundColor: UIColor) {

        label = TextLabelNode(text: text, fontSize: fontSize)
        label.zPosition = 500

        background = SignSpriteNode(color: backgroundColor, size: label.frame.size)
        background.zPosition = 0

        super.init()

        addChildren([label, background])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
