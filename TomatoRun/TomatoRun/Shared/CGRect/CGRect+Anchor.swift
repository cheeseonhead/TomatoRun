//
//  CGRect+Anchor.swift
//  ScrollerTest
//
//  Created by Cheese Onhead on 9/6/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

enum PointType {
    case topRight
    case topLeft
    case topMiddle
    case center
}

extension CGRect {
    func position(forAnchor anchor: CGPoint) -> CGPoint {
        let xOffset = anchor.x * size.width
        let yOffset = anchor.y * size.height

        let anchorX = origin.x + xOffset
        let anchorY = origin.y + yOffset

        return CGPoint(x: anchorX, y: anchorY)
    }

    func position(forType type: PointType) -> CGPoint {
        return position(forAnchor: CGRect.anchor(forType: type))
    }

    static func anchor(forType type: PointType) -> CGPoint {
        switch type {
        case .topRight:
            return CGPoint(x: 1, y: 1)
        case .topLeft:
            return CGPoint(x: 0, y: 1)
        case .topMiddle:
            return CGPoint(x: 0.5, y: 1)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        }
    }
}
