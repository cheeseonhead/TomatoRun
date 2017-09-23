//
//  DangerComponent.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-22.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class DangerComponent: GKComponent {
    func isTouching(_ spriteNode: SKSpriteNode) -> Bool {
        guard let entity = entity, let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return false }

        let selfNode = spriteComponent.node

        return selfNode.intersects(spriteNode)
    }
}
