//
//  GameScene.swift
//  ScrollerTest
//
//  Created by Jeffrey Wu on 2017-09-01.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class RunScene: SKScene, RunPresentable {
    let numberOfRopes = RunSceneConstants.numOfRopes

    var entities = [GKEntity]()
    var graphs = [String: GKGraph]()

    var entityManager: EntityManager!
    var tomatoBottomPadding: CGFloat!
    var segmentRenderer: SegmentRenderer!
    var uiRenderer: UIRenderer!
    var pauseScene: PauseScene!

    var worldNode: SKNode!

    var gameStateMachine: GameStateMachine!
    weak var runViewController: RunViewController?

    var cameraNode: SKCameraNode!
    var tomato: TomatoEntity!

    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        worldNode = SKNode()
        addChild(worldNode)
        tomatoBottomPadding = RunSceneConstants.tomatoBottomPadding
        entityManager = EntityManager(worldNode: worldNode)
        segmentRenderer = SegmentRenderer(scene: self)
        uiRenderer = UIRenderer(scene: self)
        pauseScene = PauseScene(size: CGSize.zero, scene: self)

        addSidebar()
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
            pauseScene.zPosition = RunSceneConstants.ZPositions.pauseScene

            camera.addChild(pauseScene)
        } else if let curState = gameStateMachine.currentState as? GameOverState {
            worldNode.isPaused = true

            guard let score = tomato.component(ofType: ScoreComponent.self)?.score else { return }

            curState.finalScore = score

            runViewController?.presentGameOverScene()
        }

        segmentRenderer.update(currentTime)
        uiRenderer.update(currentTime)
    }

    override func didFinishUpdate() {
        super.didFinishUpdate()
        positionCamera()
        removeOffScreenSprites()
    }
}

extension RunScene {

    func positionCamera() {
        guard let tomatoY = tomato.getPosition()?.y,
            let screenHeight = cameraNode.renderSize()?.height else { return }

        let finalYPos = tomatoY + 0.5 * screenHeight - tomatoBottomPadding
        cameraNode.position.y = finalYPos
    }

    func removeOffScreenSprites() {
        for entity in entityManager.entities {
            guard let spriteNode = entity.component(ofType: SpriteComponent.self)?.node,
                let curPosition = entity.getPosition() else { continue }

            if !cameraNode.contains(spriteNode), curPosition.y < cameraNode.position.y {
                entityManager.remove(entity)
            }
        }
    }
}

// MARK: Adding Entities
extension RunScene {

    func addBoards(_ infos: [(CGFloat, Int)]) {
        infos.forEach { height, ropeIndex in
            let board = WoodenBoardEntity(fittingWidth: ropeSpacing(), entityManager: entityManager)

            addEntity(board, toRope: ropeIndex, atHeight: height)
        }
    }

    func addSpiders(_ infos: [(CGFloat, Int)]) {
        infos.forEach { height, ropeIndex in
            let spider = SpiderEntity(fittingWidth: ropeSpacing() * RunSceneConstants.WidthRatio.spider)

            addEntity(spider, toRope: ropeIndex, atHeight: height)
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

    func addSidebar() {
        let sidebarLeft = SidebarEntity(position: CGPoint(x: 0, y: 0), scene: self)
        entityManager.add(sidebarLeft)
        let sidebarRight = SidebarEntity(position: CGPoint(x: size.width, y: 0), scene: self)
        entityManager.add(sidebarRight)
    }

    func addCamera() {
        cameraNode = SKCameraNode()

        camera = cameraNode
        addChild(cameraNode)

        cameraNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
    }

    func addTomato() {
        let ropeNumber = 0 // Int.random(min: 0, max: numberOfRopes)

        tomato = TomatoEntity(speed: RunSceneConstants.tomatoSpeed, fittingWidth: ropeSpacing() * RunSceneConstants.WidthRatio.tomato, entityManager: entityManager)
        let xPos = ropeXPos(forIndex: ropeNumber)
        tomato.setPosition(CGPoint(x: xPos, y: tomatoBottomPadding))

        entityManager.add(tomato)
    }
}

// MARK: Helpers
private extension RunScene {

    func ropeSpacing() -> CGFloat {
        return size.width * RunSceneConstants.WidthRatio.ropeSpacing / CGFloat(numberOfRopes)
    }

    func ropeXPos(forIndex index: Int) -> CGFloat {
        let spacing = ropeSpacing()
        let leftSpacing = (size.width - spacing * CGFloat(numberOfRopes - 1)) / 2

        return leftSpacing + spacing * CGFloat(index)
    }

    func addEntity<T: GKEntity & Positionable>(_ entity: T, toRope rope: Int, atHeight height: CGFloat) {
        guard rope < numberOfRopes else { return }

        let xPos = ropeXPos(forIndex: rope)
        entity.setPosition(CGPoint(x: xPos, y: height))

        entityManager.add(entity)
    }
}
