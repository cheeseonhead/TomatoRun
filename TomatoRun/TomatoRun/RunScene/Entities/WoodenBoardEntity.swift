//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class WoodenBoardEntity: GKEntity {
    let intersectionAnchors = [CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5)]

    init(fittingWidth: CGFloat) {
        super.init()

        let texture = SKTexture(imageNamed: ImageConstants.WoodenBoardImageName)

        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.anchorPoint = CGPoint(x: 0, y: 0.5)
        spriteComponent.node.scale(toWidth: fittingWidth)

        addComponent(spriteComponent)
        addComponent(IntersectionComponent(anchors: intersectionAnchors))
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setPosition(_ position: CGPoint) {
        guard let spriteNode = component(ofType: SpriteComponent.self)?.node else {
            return
        }

        spriteNode.position = position
    }
}
