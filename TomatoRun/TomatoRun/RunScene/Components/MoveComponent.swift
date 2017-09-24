//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class MoveComponent: GKComponent {
    let entityManager: EntityManager
    let stateMachine: MoveStateMachine

    var curDestination: CGPoint?
    weak var curIntersectionComponent: IntersectionComponent?
    var speed: CGFloat

    init(speed: CGFloat, stateMachine: MoveStateMachine, entityManager: EntityManager) {
        self.stateMachine = stateMachine
        self.entityManager = entityManager
        self.speed = speed

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        guard !(stateMachine.currentState is DuringTravelState) else { return }

        guard let node = entity?.component(ofType: SpriteComponent.self)?.node else { return }

        let curPosition = node.position
        let intersectionComponents = entityManager.components(ofType: IntersectionComponent.self)

        if stateMachine.currentState is IdleOnStartState, let startPoint = curDestination,
            let curIntersection = curIntersectionComponent {
            let path = curIntersection.pathToTravel(withStarting: startPoint)

            curIntersection.canBreak = false

            redirect(node: node, onPath: path, completion: {
                curIntersection.canBreak = true
                assert(self.stateMachine.enter(IdleState.self))
            })
            return
        }

        // Finding the appropriate intersection to go to
        var bestIntersectionComponent: IntersectionComponent?
        var bestPoint: CGPoint?

        (bestPoint, bestIntersectionComponent) = findBestIntersection(curPosition: curPosition, components: intersectionComponents)

        if bestPoint == nil {
            if !(stateMachine.currentState is WanderingState) {
                assert(stateMachine.enter(WanderingState.self))
                curDestination = nil

                let pointToGo = CGPoint(x: curPosition.x, y: curPosition.y + 1000)
                redirect(node: node, toPosition: pointToGo, completion: {
                    assert(self.stateMachine.enter(IdleState.self))
                })
            }
        } else {
            if bestPoint != curDestination {
                guard stateMachine.enter(TravelToStartState.self) else { return }

                curDestination = bestPoint

                curIntersectionComponent = bestIntersectionComponent

                redirect(node: node, toPosition: curDestination!, completion: {
                    self.curIntersectionComponent?.canBreak = false
                    assert(self.stateMachine.enter(IdleOnStartState.self))
                })
            }
        }
    }
}

// MARK: Helpers
private extension MoveComponent {
    func redirect(node: SKSpriteNode, toPosition position: CGPoint, completion block: @escaping () -> Swift.Void) {
        let curPosition = node.position
        let distance = (position - curPosition).length()
        let action = SKAction.move(to: position, duration: Double(distance / speed))

        node.removeAllActions()
        node.run(action, completion: block)
    }

    func redirect(node: SKSpriteNode, onPath path: [CGPoint], completion block: @escaping () -> Swift.Void) {
        guard path.count >= 2 else { return }

        var actionSequence = [SKAction]()
        for index in 1 ..< path.count {
            let point = path[index]

            let distance = (point - path[index - 1]).length()
            let action = SKAction.move(to: point, duration: Double(distance / speed))

            actionSequence.append(action)
        }

        stateMachine.enter(DuringTravelState.self)
        node.run(SKAction.sequence(actionSequence), completion: block)
    }

    func findBestIntersection(curPosition: CGPoint, components: Set<IntersectionComponent>) -> MoveState? {
        var bestIntersectionComponent: IntersectionComponent?
        var bestPoint: CGPoint?

        for intersectionComponent in components {
            for intersection in intersectionComponent.intersections {
                let roundedIntersectX = intersection.x.rounded(.toNearestOrAwayFromZero)
                let roundedPositionX = curPosition.x.rounded(.toNearestOrAwayFromZero)
                let roundedIntersectY = intersection.y.rounded(.toNearestOrAwayFromZero)

                if roundedIntersectX == roundedPositionX, roundedIntersectY > curPosition.y {
                    if bestPoint == nil || roundedIntersectY < bestPoint!.y {
                        bestPoint = intersection
                        bestIntersectionComponent = intersectionComponent
                    }
                }
            }
        }

        guard let point = bestPoint, let intersection = bestIntersectionComponent else { return }
        
        return MoveState(startPoint: point, targetIntersection: intersection)
    }
}
