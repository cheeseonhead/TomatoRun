//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class Tomato: GKEntity
{
    var stateMachine: MoveStateMachine!
    
    init(entityManager: EntityManager)
    {
        super.init()
        
        initStateMachine()
        initComponents(entityManager)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Initialization
private extension Tomato
{
    func initComponents(_ entityManager: EntityManager)
    {
        let texture = SKTexture(imageNamed: "Spaceship")
        let spriteComponent = SpriteComponent(texture: texture)
        
        spriteComponent.node.scale(toWidth: 150)
        
        addComponent(spriteComponent)
        addComponent(MoveComponentV2(speed: 300, stateMachine: stateMachine, entityManager: entityManager))
    }
    
    func initStateMachine()
    {
        stateMachine = MoveStateMachine()
    }
}
