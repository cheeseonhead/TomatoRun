//
//  CGRect+Position.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension CGRect {
    static func positioned(anchor: CGPoint, at point: CGPoint) -> (CGRect) -> CGRect {
        return { frame in
            let offset = point - frame.position(forAnchor: anchor)
            let newOrigin = frame.origin + offset

            return CGRect(origin: newOrigin, size: frame.size)
        }
    }

    static func positioned(anchorType type: PointType, at point: CGPoint) -> (CGRect) -> CGRect {

        return { frame in
            let anchorPoint = CGRect.anchor(forType: type)

            return positioned(anchor: anchorPoint, at: point)(frame)
        }
    }
}
