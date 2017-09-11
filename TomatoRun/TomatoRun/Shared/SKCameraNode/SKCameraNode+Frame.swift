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
    func renderFrame() -> CGRect? {
        guard let renderSize = renderSize() else { return nil }

        let xPos = position.x - renderSize.width / 2
        let yPos = position.y - renderSize.height / 2

        return CGRect(x: xPos, y: yPos, width: renderSize.width, height: renderSize.height)
    }
}

private extension SKCameraNode {
    func renderSize() -> CGSize? {
        guard let scene = scene else { return nil }

        let height = yScale * scene.size.height
        let width = xScale * scene.size.width

        return CGSize(width: width, height: height)
    }
}
