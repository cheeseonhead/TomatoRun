//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

private let actionName = "MoveAction"
private var actionIndex = 0

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

        guard let node = entity?.component(ofType: SpriteComponent.self)?.node else { return }

        let intersectionComponents = entityManager.components(ofType: IntersectionComponent.self)

        // Finding the appropriate intersection to go to
        let bestTarget = findBestIntersection(curPosition: node.position, components: intersectionComponents)

        // Move to the correct state
        if let state = stateMachine.currentState as? WanderingState {
            state.target = bestTarget
            if stateMachine.canEnterState(StartFoundState.self) {
                stateMachine.enter(StartFoundState.self)
            }
        } else if let state = stateMachine.currentState as? TravelingToStartState {
            if state.target != bestTarget {
                state.target = bestTarget

                if bestTarget != nil {
                    stateMachine.enter(StartFoundState.self)
                } else {
                    stateMachine.enter(WanderingState.self)
                }
            }
        }

        // Process using the state
        if stateMachine.currentState is WanderingState, !node.hasActions() {
            let pointToGo = CGPoint(x: node.position.x, y: node.position.y + 1000)
            redirect(node: node, toPosition: pointToGo, completion: {})
        } else if let state = stateMachine.currentState as? StartFoundState, let target = state.target {
            stateMachine.enter(TravelingToStartState.self)
            redirect(node: node, toPosition: target.startPoint, completion: {
                target.targetIntersection.canBreak = false
                self.stateMachine.enter(IdleOnStartState.self)
            })
        } else if let state = stateMachine.currentState as? IdleOnStartState, let target = state.target {
            let path = target.targetIntersection.pathToTravel(withStarting: target.startPoint)

            stateMachine.enter(DuringTravelState.self)
            redirect(node: node, onPath: path, completion: {
                target.targetIntersection.canBreak = true
                self.stateMachine.enter(WanderingState.self)
            })
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

    func findBestIntersection(curPosition: CGPoint, components: Set<IntersectionComponent>) -> Target? {
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

        guard let point = bestPoint, let intersection = bestIntersectionComponent else { return nil }

        return Target(startPoint: point, targetIntersection: intersection)
    }
}
