//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class Tomato: GKEntity {
    var stateMachine: MoveStateMachine!

    init(speed: CGFloat, fittingWidth: CGFloat, entityManager: EntityManager) {
        super.init()

        initStateMachine()
        initComponents(speed: speed, fittingWidth: fittingWidth, entityManager)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initialization
private extension Tomato {
    func initComponents(speed: CGFloat, fittingWidth: CGFloat, _ entityManager: EntityManager) {
        let texture = SKTexture(imageNamed: ImageConstants.TomatoImageName)
        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.scale(toWidth: fittingWidth)

        addComponent(spriteComponent)
        addComponent(MoveComponent(speed: speed, stateMachine: stateMachine, entityManager: entityManager))
    }

    func initStateMachine() {
        stateMachine = MoveStateMachine()
    }
}
