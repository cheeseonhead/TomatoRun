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

    var cameraNode: SKCameraNode!
    var tomato: TomatoEntity!

    // Update time
    var lastUpdateTimeInterval: TimeInterval = 0

    override func didMove(to view: SKView) {
        super.didMove(to: view)

        tomatoBottomPadding = RunSceneConstants.TomatoBottomPadding
        entityManager = EntityManager(scene: self)
        segmentRenderer = SegmentRenderer(scene: self)

        addRopes()
        addCamera()
        addTomato()
        initialAddBoards()

        temp()
    }

    override func update(_ currentTime: TimeInterval) {
        let deltaTime = currentTime - lastUpdateTimeInterval
        lastUpdateTimeInterval = currentTime

        entityManager.update(deltaTime)
        positionCamera()
    }
}

extension RunScene {
    func positionCamera() {
        guard let tomatoY = tomato.getPosition()?.y else { return }
        let screenHeight = size.height

        let finalYPos = tomatoY + 0.5 * screenHeight - tomatoBottomPadding
        cameraNode.position.y = finalYPos
    }
}

// MARK: Adding Entities
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
        //        let ropeNumber = Int.random(min: 0, max: numberOfRopes)
        let ropeNumber = 2

        tomato = TomatoEntity(speed: 300, fittingWidth: RunSceneConstants.TomatoWidth, entityManager: entityManager)
        if let spriteComponent = tomato.component(ofType: SpriteComponent.self) {
            let xPos = ropeXPos(forIndex: ropeNumber)
            spriteComponent.node.position = CGPoint(x: xPos, y: tomatoBottomPadding)
            spriteComponent.node.zPosition = 3
        }

        entityManager.add(tomato)
    }

    func addBoards(atHeights heights: [CGFloat], ropeIndex: [Int]) {
        guard heights.count == ropeIndex.count else { return }

        for i in 0 ..< heights.count {
            let board = WoodenBoardEntity(fittingWidth: ropeSpacing())

            guard ropeIndex[i] < numberOfRopes else { continue }

            let xPos = ropeXPos(forIndex: ropeIndex[i])
            board.setPosition(CGPoint(x: xPos, y: heights[i]))

            entityManager.add(board)
        }
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
}

// MARK: Temperary Helpers
private extension RunScene {
    func initialAddBoards() {
        let height: [CGFloat] = [200, 450, 2000, 250, 300]
        let index = [0, 1, 1, 2, 2]

        addBoards(atHeights: height, ropeIndex: index)
    }

    func temp() {
    }
}
