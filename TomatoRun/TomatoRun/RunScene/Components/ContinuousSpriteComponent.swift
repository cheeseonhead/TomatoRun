//
// Created by Jeffrey Wu on 2017-09-03.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit
import SpriteKit

class ContinuousSpriteComponent: GKComponent {
    unowned let scene: SKScene

    let texture: SKTexture
    let position: CGPoint
    let zPosition: CGFloat

    // MARK: States
    var visibleNodes = Set<SKSpriteNode>()
    var unusedNodes = Set<SKSpriteNode>()
    var nextRopeYPos: CGFloat

    init(scene: SKScene, texture: SKTexture, position: CGPoint, zPosition: CGFloat) {
        self.scene = scene
        self.texture = texture
        self.position = position
        self.zPosition = zPosition

        nextRopeYPos = self.position.y

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Updates
extension ContinuousSpriteComponent: Spriteful {
    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        removeOffScreenSprites()
        fillScreenWithSprites()
    }

    func removeFromParent() {
        for node in visibleNodes {
            node.removeFromParent()
        }
        visibleNodes.removeAll()
        for node in unusedNodes {
            node.removeFromParent()
        }
        unusedNodes.removeAll()
    }
}

// MARK: Sprite Manipulation
private extension ContinuousSpriteComponent {
    func fillScreenWithSprites() {

        guard let renderedFrame = scene.camera?.renderedFrame() else { return }

        let maxY = renderedFrame.position(forAnchor: CGPoint(x: 0.5, y: 1.0)).y

        while nextRopeYPos <= maxY {
            addSprite(at: CGPoint(x: position.x, y: nextRopeYPos))
        }
    }

    func addSprite(at position: CGPoint) {
        var newNode: SKSpriteNode!

        if unusedNodes.count > 0 {
            newNode = unusedNodes[unusedNodes.startIndex]
            unusedNodes.remove(newNode)
        } else {
            newNode = createSprite()
            scene.addChild(newNode)
        }

        newNode.position = CGPoint(x: position.x, y: nextRopeYPos)
        nextRopeYPos += newNode.size.height
        visibleNodes.insert(newNode)
    }

    func createSprite() -> SKSpriteNode {
        let node = SKSpriteNode(texture: texture)
        node.anchorPoint = CGPoint(x: 0.5, y: 0)
        node.zPosition = zPosition

        return node
    }

    func removeOffScreenSprites() {
        guard let camera = scene.camera else {
            return
        }

        for node in visibleNodes {
            if !camera.contains(node) {
                visibleNodes.remove(node)
                unusedNodes.insert(node)
            }
        }
    }
}

extension ContinuousSpriteComponent: Positional {
    func getPosition() -> CGPoint {
        return position
    }
}
