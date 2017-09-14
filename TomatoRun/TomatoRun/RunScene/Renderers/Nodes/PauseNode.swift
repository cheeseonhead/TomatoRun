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
        super.init(texture: nil, color: .red, size: size)
        anchorPoint = CGPoint(x: 1, y: 1)
        zPosition = RunSceneConstants.ZPositions.UIZPosition
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
