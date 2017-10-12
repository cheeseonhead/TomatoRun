//
//  TextLabel.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/11/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class TextLabelNode: SKLabelNode {
    override init() {
        super.init()
    }

    required init(text: String, fontSize: FontSize) {
        super.init(fontNamed: "Pixeled")

        self.text = text
        self.fontSize = fontSize.rawValue
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
