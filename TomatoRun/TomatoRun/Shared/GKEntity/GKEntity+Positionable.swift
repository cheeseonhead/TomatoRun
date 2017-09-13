//
//  GKEntity+Positionable.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

extension Positionable where Self: GKEntity {
    func setPosition(_ position: CGPoint) {
        guard let spriteNode = component(ofType: SpriteComponent.self)?.node else {
            return
        }

        spriteNode.position = position
    }
    
    func getPosition() -> CGPoint {
        guard let spriteNode = component(ofType: SpriteComponent.self)?.node else {
            return CGPoint.zero
        }
        
        return spriteNode.position
    }
}
