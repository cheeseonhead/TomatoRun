//
//  SidebarEntity.swift
//  TomatoRun
//
//  Created by Andy Sheng on 2017-09-27.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class SidebarEntity: GKEntity {
    init(position: CGPoint, scene: SKScene) {
        super.init()

        let texture = SKTexture(imageNamed: ImageConstants.SidebarImageName)
        let continuousSprite = ContinuousSpriteComponent(scene: scene, texture: texture, position: position, zPosition: RunSceneConstants.ZPositions.Sidebar)

        addComponent(continuousSprite)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
