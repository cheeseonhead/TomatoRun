//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class Rope: GKEntity
{
    init(position: CGPoint, scene: SKScene)
    {
        super.init()

        let texture = SKTexture(imageNamed: "Rope")
        let continuousSprite = ContinuousSpriteComponent(scene: scene, texture: texture, position: position)

        addComponent(continuousSprite)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
