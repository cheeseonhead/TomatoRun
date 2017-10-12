//
//  SKNode+Position.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/11/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKNode {
    func position(anchor: CGPoint, at point: CGPoint) {
        let anchorOffset = position - frame.position(forAnchor: anchor)
        let newPosition = point + anchorOffset

        position = newPosition
    }

    func position(anchorType type: PointType, at point: CGPoint) {
        let anchorPoint = CGRect.anchor(forType: type)

        position(anchor: anchorPoint, at: point)
    }
}
