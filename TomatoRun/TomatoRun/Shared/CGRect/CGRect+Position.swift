//
//  CGRect+Position.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension CGRect {
    func positioned(anchor: CGPoint, at _: CGPoint) -> CGRect {
        let offset = origin - position(forAnchor: anchor)
        let newOrigin = origin + offset

        return CGRect(origin: newOrigin, size: size)
    }

    func positioned(anchorType type: PointType, at point: CGPoint) -> CGRect {
        let anchorPoint = CGRect.anchor(forType: type)

        return positioned(anchor: anchorPoint, at: point)
    }
}
