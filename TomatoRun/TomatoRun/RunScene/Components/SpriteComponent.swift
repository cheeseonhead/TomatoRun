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
        node.entity = entity
    }
}

extension SpriteComponent: Positional {
    func getPosition() -> CGPoint {
        return node.position
    }
}

extension SpriteComponent: Framable {
    func frame() -> CGRect {
        return node.frame
    }
}
