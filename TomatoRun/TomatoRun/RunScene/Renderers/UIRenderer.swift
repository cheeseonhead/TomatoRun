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

    init(scene: RunScene) {
        self.scene = scene
    }

    func addUINodes() {
        guard let camera = scene.camera else { return }

        addPauseNode(camera)
    }
}

// MARK: - Adding Nodes
private extension UIRenderer {
    func addPauseNode(_ camera: SKCameraNode) {
        let fittingDimension = scene.size.width * 0.1
        pauseNode = PauseNode(size: CGSize(width: fittingDimension, height: fittingDimension))

        guard let renderSize = camera.renderSize() else { return }

        let frame = CGRect(x: 0, y: 0, width: renderSize.width / 2, height: renderSize.height / 2)
        let topRight = frame.position(forType: .topRight)

        let padding = fittingDimension * 0.7

        pauseNode.position = topRight - CGPoint(x: padding, y: padding)
        camera.addChild(pauseNode)
    }
}
