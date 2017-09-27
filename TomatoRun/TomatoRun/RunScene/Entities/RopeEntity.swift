//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class RopeEntity: GKEntity {
    init(position: CGPoint, scene: SKScene) {
        super.init()

        let texture = SKTexture(imageNamed: ImageConstants.RopeImageName)
        let continuousSprite = ContinuousSpriteComponent(scene: scene, texture: texture, position: position, zPosition: RunSceneConstants.ZPositions.rope)

        addComponent(continuousSprite)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
