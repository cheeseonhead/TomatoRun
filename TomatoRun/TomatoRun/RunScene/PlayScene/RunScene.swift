//
//  GameScene.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-01.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class RunScene: SKScene {
    let numberOfRopes = RunSceneConstants.NumOfRopes

    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()

    var entityManager: EntityManager!
    var tomatoBottomPadding: CGFloat!
    var segmentRenderer: SegmentRenderer!
    var uiRenderer: UIRenderer!
    var pauseScene: PauseScene!

    var worldNode: SKNode!

    var gameStateMachine: GameStateMachine!

    var cameraNode: SKCameraNode!
    var tomato: TomatoEntity!

    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        worldNode = SKNode()
        addChild(worldNode)
        tomatoBottomPadding = RunSceneConstants.TomatoBottomPadding
        entityManager = EntityManager(worldNode: worldNode)
        segmentRenderer = SegmentRenderer(scene: self)
        uiRenderer = UIRenderer(scene: self)
        gameStateMachine = GameStateMachine()
        pauseScene = PauseScene(size: CGSize.zero, scene: self)

        addRopes()
        addCamera()
        uiRenderer.addUINodes()
        addTomato()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchedNodes = nodes(at: touch.location(in: self))

        for node in touchedNodes {
            guard let entity = node.entity,
                let touchComponent = entity.component(ofType: TouchComponent.self) else { continue }

            touchComponent.handler()
        }

        uiRenderer.touchesBegan(touches, with: event)
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        if gameStateMachine.currentState is GamePlayingState {
            camera?.removeChildren(in: [pauseScene])

            worldNode.isPaused = false

            entityManager.update(deltaTime)

            if let dead = tomato.component(ofType: DeathComponent.self)?.isDead, dead {
                gameStateMachine.enter(GameOverState.self)
            }
        } else if gameStateMachine.currentState is GamePausedState {
            guard let camera = camera, !camera.children.contains(pauseScene), let size = camera.renderSize() else { return }

            worldNode.isPaused = true

            pauseScene.size = size
            pauseScene.position = CGPoint.zero
            pauseScene.zPosition = RunSceneConstants.ZPositions.PauseScene

            camera.addChild(pauseScene)
        } else if gameStateMachine.currentState is GameOverState {
            worldNode.isPaused = true

            presentScene(fileNamed: "GameOverScene", getSKScene: { gkScene in gkScene.rootNode as? GameOverScene })
        }

        segmentRenderer.update(currentTime)
        uiRenderer.update(currentTime)
        positionCamera()
    }
}

extension RunScene {
    func positionCamera() {
        guard let tomatoY = tomato.getPosition()?.y,
            let screenHeight = cameraNode.renderSize()?.height else { return }

        let finalYPos = tomatoY + 0.5 * screenHeight - tomatoBottomPadding
        cameraNode.position.y = finalYPos
    }
}

// MARK: Adding Entities
extension RunScene {
    func addBoards(atHeights heights: [CGFloat], ropeIndex: [Int]) {
        guard heights.count == ropeIndex.count else { return }

        for i in 0 ..< heights.count {
            let board = WoodenBoardEntity(fittingWidth: ropeSpacing(), entityManager: entityManager)

            addEntity(board, toRope: ropeIndex[i], atHeight: heights[i])
        }
    }

    func addSpiders(atHeights heights: [CGFloat], ropeIndex: [Int]) {
        guard heights.count == ropeIndex.count else { return }

        for i in 0 ..< heights.count {
            let spider = SpiderEntity(fittingWidth: size.width * 0.1)

            addEntity(spider, toRope: ropeIndex[i], atHeight: heights[i])
        }
    }
}

private extension RunScene {
    func addRopes() {
        for i in 0 ..< numberOfRopes {
            let xPos = ropeXPos(forIndex: i)

            let rope = RopeEntity(position: CGPoint(x: xPos, y: 0), scene: self)
            entityManager.add(rope)
        }
    }

    func addCamera() {
        cameraNode = SKCameraNode()

        camera = cameraNode
        addChild(cameraNode)

        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }

    func addTomato() {
        let ropeNumber = Int.random(min: 0, max: numberOfRopes)

        tomato = TomatoEntity(speed: 100, fittingWidth: RunSceneConstants.TomatoWidth, entityManager: entityManager)
        let xPos = ropeXPos(forIndex: ropeNumber)
        tomato.setPosition(CGPoint(x: xPos, y: tomatoBottomPadding))

        entityManager.add(tomato)
    }
}

// MARK: Helpers
private extension RunScene {
    func ropeSpacing() -> CGFloat {
        return size.width / CGFloat(numberOfRopes)
    }

    func ropeXPos(forIndex index: Int) -> CGFloat {
        let spacing = ropeSpacing()
        let leftSpacing = spacing / 2

        return leftSpacing + spacing * CGFloat(index)
    }

    func addEntity<T: GKEntity & Positionable>(_ entity: T, toRope rope: Int, atHeight height: CGFloat) {
        guard rope < numberOfRopes else { return }

        let xPos = ropeXPos(forIndex: rope)
        entity.setPosition(CGPoint(x: xPos, y: height))

        entityManager.add(entity)
    }
}
