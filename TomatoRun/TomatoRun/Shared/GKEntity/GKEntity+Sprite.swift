//
//  GKEntity+Sprite.swift
//  ScrollerTest
//
//  Created by Cheese Onhead on 9/6/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

extension GKEntity {
    func getPosition() -> CGPoint? {
        for component in components {
            if let positionalComponent = component as? Positional {
                return positionalComponent.getPosition()
            }
        }

        return nil
    }

    func size() -> CGSize? {
        guard let spriteComponent = self.component(ofType: SpriteComponent.self) else {
            return nil
        }

        return spriteComponent.node.size
    }

    func frame() -> CGRect? {
        for component in components {
            if let framableComponent = component as? Framable {
                return framableComponent.frame()
            }
        }

        return nil
    }
}
