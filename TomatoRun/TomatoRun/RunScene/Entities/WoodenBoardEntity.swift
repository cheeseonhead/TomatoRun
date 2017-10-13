//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class WoodenBoardEntity: GKEntity, Positionable {
    let intersectionAnchors = [CGPoint(x: 0, y: 0.5), CGPoint(x: 1, y: 0.5)]

    init(fittingWidth: CGFloat, entityManager: EntityManager, textEnabled: Bool) {
        super.init()

        let texture = SKTexture(imageNamed: ImageConstants.WoodenBoardImageName)

        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.anchorPoint = CGPoint(x: 0, y: 0.5)
        spriteComponent.node.scale(toWidth: fittingWidth)
        spriteComponent.node.zPosition = RunSceneConstants.ZPositions.boards

        addComponent(spriteComponent)
        addComponent(IntersectionComponent(anchors: intersectionAnchors))
        addComponent(TouchComponent(handler: { [unowned self] in
            guard let intersection = self.component(ofType: IntersectionComponent.self),
                intersection.canBreak else { return }

            entityManager.remove(self)
        }))

        if textEnabled {
            addComponent(TextLabelComponent(text: Text.break, color: UIColor.orange, anchor: CGPoint(x: 0.5, y: 1), worldNode: entityManager.worldNode))
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
