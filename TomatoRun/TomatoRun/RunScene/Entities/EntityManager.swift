//
// Created by Jeffrey Wu on 2017-09-01.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class EntityManager {
    unowned let worldNode: SKNode

    var entities = Set<GKEntity>()
    var toRemove = Set<GKEntity>()
    lazy var componentSystems: [GKComponentSystem] = {
        let moveSystem = GKComponentSystem(componentClass: MoveComponent.self)
        let continuousSpriteSystem = GKComponentSystem(componentClass: ContinuousSpriteComponent.self)
        let intersectionSystem = GKComponentSystem(componentClass: IntersectionComponent.self)
        let touchSystem = GKComponentSystem(componentClass: TouchComponent.self)
        let scoreSystem = GKComponentSystem(componentClass: ScoreComponent.self)
        let deathSystem = GKComponentSystem(componentClass: DeathComponent.self)
        let textLabelSystem = GKComponentSystem(componentClass: TextLabelComponent.self)
        return [intersectionSystem, moveSystem, deathSystem, continuousSpriteSystem, textLabelSystem, touchSystem, scoreSystem]
    }()

    init(worldNode: SKNode) {
        self.worldNode = worldNode
    }

    func update(_ deltaTime: CFTimeInterval) {
        for currentRemove in toRemove {
            for component in currentRemove.components {
                guard let spriteful = component as? Spriteful else { continue }
                spriteful.removeFromParent()
            }

            entities.remove(currentRemove)
            for componentSystem in componentSystems {
                componentSystem.removeComponent(foundIn: currentRemove)
            }
        }

        for componentSystem in componentSystems {
            componentSystem.update(deltaTime: deltaTime)
        }

        toRemove.removeAll()
    }
}

// MARK: Editing
extension EntityManager {
    func add(_ entity: GKEntity) {
        entities.insert(entity)

        if let spriteNode = entity.component(ofType: SpriteComponent.self)?.node {
            worldNode.addChild(spriteNode)
        }

        for componentSystem in componentSystems {
            componentSystem.addComponent(foundIn: entity)
        }
    }

    func remove(_ entity: GKEntity) {
        toRemove.insert(entity)
    }
}

// MARK: Access
extension EntityManager {
    func entities<EntityType>(ofType _: EntityType.Type) -> [EntityType] {
        return entities.compactMap { entity in
            if let matched = entity as? EntityType {
                return matched
            }

            return nil
        }
    }

    func entity<EntityType>(ofType _: EntityType.Type, compare: (EntityType, EntityType?) -> Bool) -> EntityType? {
        var target: EntityType?

        for entity in entities {
            if let matched = entity as? EntityType {
                if compare(matched, target) {
                    target = matched
                }
            }
        }

        return target
    }

    func components<ComponentType: GKComponent>(ofType _: ComponentType.Type) -> Set<ComponentType> {
        var components = Set<ComponentType>()

        for entity in entities {
            if let targetComponent = entity.component(ofType: ComponentType.self) {
                components.insert(targetComponent)
            }
        }

        return components
    }
}
