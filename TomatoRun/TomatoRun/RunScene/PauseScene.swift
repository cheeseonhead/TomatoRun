//
//  PauseScene.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-20.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class PauseScene: SKSpriteNode {
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)

        let label = SKLabelNode(text: "Resume")
        label.position = CGPoint(x: 0, y: 0)

        addChild(label)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
