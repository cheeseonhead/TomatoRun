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
    case bottomLeft
    case bottomMiddle
    case bottomRight
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
        case .bottomLeft:
            return CGPoint(x: 0, y: 0)
        case .bottomRight:
            return CGPoint(x: 1, y: 0)
        case .bottomMiddle:
            return CGPoint(x: 0.5, y: 0)
        }
    }

    func position(forEdge edge: CGRectEdge) -> CGFloat {
        switch edge {
        case .minXEdge:
            return origin.x
        case .minYEdge:
            return origin.y
        case .maxXEdge:
            return origin.x + size.width
        case .maxYEdge:
            return origin.y + size.height
        }
    }

    func positioned(edge: CGRectEdge, at line: CGFloat) -> CGRect {
        var newOrigin = origin
        switch edge {
        case .minXEdge:
            newOrigin.x = line
        case .minYEdge:
            newOrigin.y = line
        case .maxXEdge:
            newOrigin.x = line - size.width
        case .maxYEdge:
            newOrigin.y = line - size.height
        }
        return CGRect(origin: newOrigin, size: size)
    }
}
