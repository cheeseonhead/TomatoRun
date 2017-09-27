//
//  PauseNode.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class PauseNode: SKSpriteNode {
    init(size: CGSize) {
        let texture = SKTexture(imageNamed: ImageConstants.PauseImageName)
        super.init(texture: texture, color: .red, size: size)
        anchorPoint = CGPoint(x: 1, y: 1)
        zPosition = RunSceneConstants.ZPositions.uiZPosition
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
