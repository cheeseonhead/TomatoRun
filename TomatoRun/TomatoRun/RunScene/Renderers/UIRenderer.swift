//
//  UIRenderer.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class UIRenderer {
    unowned let scene: RunScene

    // MARK: Nodes
    var pauseNode: SKSpriteNode!
    var scoreNode: ScoreLabelNode!

    init(scene: RunScene) {
        self.scene = scene
    }

    func addUINodes() {
        guard let camera = scene.camera else { return }

        addPauseNode(camera)
        addScoreLabel(camera)
    }

    func update(_: TimeInterval) {
        guard let score = scene.tomato.component(ofType: ScoreComponent.self)?.score else { return }
        scoreNode.score = score

        guard let camera = scene.camera else { return }
        positionScoreLabel(camera)
    }

    func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first else { return }

        let touchedNodes = scene.nodes(at: touch.location(in: scene))

        if touchedNodes.contains(pauseNode), scene.gameStateMachine.canEnterState(GamePausedState.self) {
            scene.gameStateMachine.enter(GamePausedState.self)
        }
    }
}

// MARK: - Adding Nodes
private extension UIRenderer {
    func addPauseNode(_ camera: SKCameraNode) {
        let fittingDimension = scene.size.width * RunSceneConstants.WidthRatio.pauseNode
        let padding = scene.size.width * RunSceneConstants.PaddingRatio.pauseNode

        pauseNode = PauseNode(size: CGSize(width: fittingDimension, height: fittingDimension))

        guard let renderedFrame = camera.renderedFrame() else { return }
        let topRightInScene = renderedFrame.position(forType: .topRight)
        let topRightInCamera = camera.convert(topRightInScene, from: scene)

        pauseNode.position = topRightInCamera - CGPoint(x: padding, y: padding)

        camera.addChild(pauseNode)
    }

    func addScoreLabel(_ camera: SKCameraNode) {

        scoreNode = ScoreLabelNode(score: 0)

        camera.addChild(scoreNode)
    }
}

// MARK: - Positioning
private extension UIRenderer {
    func positionScoreLabel(_ camera: SKCameraNode) {
        let padding = scene.size.width * RunSceneConstants.PaddingRatio.scoreLabel

        guard let topLeftInScene = camera.renderedFrame()?.position(forType: .topLeft) else { return }
        let topLeftInCamera = camera.convert(topLeftInScene, from: scene)

        scoreNode.position = topLeftInCamera + CGPoint(x: padding, y: -(scoreNode.frame.size.height + padding))
    }
}
