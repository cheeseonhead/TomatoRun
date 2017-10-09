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
    let node: SKLabelNode

    init(text: String) {
        node = SKLabelNode(text: text)
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

extension SpriteComponent: Positionable {
    func setPosition(_ position: CGPoint) {
        node.position = position
    }

    func getPosition() -> CGPoint {
        return node.position
    }
}

extension SpriteComponent: Framable {
    func frame() -> CGRect {
        return node.frame
    }
}
