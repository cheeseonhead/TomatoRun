//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class SpriteComponent: GKComponent {
    let node: SKSpriteNode

    init(texture: SKTexture) {
        node = SKSpriteNode(texture: texture, color: .white, size: texture.size())
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

extension SpriteComponent: Spriteful {
    func removeFromParent() {
        node.removeFromParent()
    }
}
