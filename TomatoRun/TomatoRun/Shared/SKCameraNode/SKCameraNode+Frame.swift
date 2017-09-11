//
//  SKCameraNode+Frame.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKCameraNode {
    // Frame puts the origin on the bottom left
    func renderedFrame() -> CGRect? {
        guard let renderSize = renderSize() else { return nil }

        let xPos = position.x - renderSize.width / 2
        let yPos = position.y - renderSize.height / 2

        return CGRect(x: xPos, y: yPos, width: renderSize.width, height: renderSize.height)
    }

    func renderSize() -> CGSize? {
        guard let scene = scene, let viewSize = scene.view?.frame.size else { return nil }

        switch scene.scaleMode {
        case .aspectFill:
            return aspectFillSize(scene, viewSize)
        default:
            return nil
        }
    }
}

private extension SKCameraNode {
    func aspectFillSize(_ scene: SKScene, _ viewSize: CGSize) -> CGSize {
        // Find width or height is the fitting one
        let sceneRatio = scene.size.height / scene.size.width
        let viewRatio = viewSize.height / viewSize.width

        if sceneRatio >= viewRatio {
            let height = viewRatio * scene.size.width
            return CGSize(width: scene.size.width, height: height)
        } else {
            let width = viewSize.width / viewSize.height * scene.size.height
            return CGSize(width: width, height: scene.size.height)
        }
    }
}
