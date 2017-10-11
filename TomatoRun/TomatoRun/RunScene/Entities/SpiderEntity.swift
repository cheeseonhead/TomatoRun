//
//  SpiderEntity.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class SpiderEntity: GKEntity, Positionable {
    init(fittingWidth: CGFloat) {
        super.init()

        let texture = SKTexture(imageNamed: ImageConstants.SpiderImageName)
        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.scale(toWidth: fittingWidth)
        spriteComponent.node.zPosition = RunSceneConstants.ZPositions.spider

        addComponent(spriteComponent)
        addComponent(DangerComponent())
    }

    //    func addTextLabel(text: String) {
    //        let textLabelComponent = TextLabelComponent(text: text)
    //        addComponent(textLabelComponent)
    //    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
