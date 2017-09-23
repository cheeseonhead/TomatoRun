//
//  DeathComponent.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-22.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class DeathComponent: GKComponent {

    unowned let entityManager: EntityManager

    var isDead = false

    init(entityManager: EntityManager) {
        self.entityManager = entityManager
        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime _: TimeInterval) {
        guard let sprite = entity?.component(ofType: SpriteComponent.self)?.node else { return }

        let allDangers = entityManager.components(ofType: DangerComponent.self)

        for danger in allDangers {
            if danger.isTouching(sprite) {
                isDead = true
                return
            }
        }
    }
}
