//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class TomatoEntity: GKEntity, Positionable {
    var stateMachine: MoveStateMachine!

    init(speed: CGFloat, fittingWidth: CGFloat, initialScore: Int, entityManager: EntityManager) {
        super.init()

        initStateMachine()
        initComponents(speed: speed, fittingWidth: fittingWidth, initialScore: initialScore, entityManager)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initialization
private extension TomatoEntity {
    func initComponents(speed: CGFloat, fittingWidth: CGFloat, initialScore: Int, _ entityManager: EntityManager) {
        let texture = SKTexture(imageNamed: ImageConstants.TomatoImageName)
        let spriteComponent = SpriteComponent(texture: texture)

        spriteComponent.node.scale(toWidth: fittingWidth)
        spriteComponent.node.zPosition = RunSceneConstants.ZPositions.tomato

        addComponent(spriteComponent)
        addComponent(MoveComponent(speed: speed, stateMachine: stateMachine, entityManager: entityManager))
        addComponent(ScoreComponent(initialScore: initialScore))
        addComponent(DeathComponent(entityManager: entityManager))
    }

    func initStateMachine() {
        stateMachine = MoveStateMachine()
    }
}
