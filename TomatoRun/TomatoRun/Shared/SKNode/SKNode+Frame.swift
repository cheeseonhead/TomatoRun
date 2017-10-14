//
//  SKNode+Frame.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-10-12.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKNode {
    func convert(frame: CGRect, to node: SKNode) -> CGRect {
        let newOrigin = convert(frame.origin, to: node)
        return CGRect(origin: newOrigin, size: frame.size)
    }

    func conver(frame: CGRect, from node: SKNode) -> CGRect {
        let newOrigin = convert(frame.origin, from: node)
        return CGRect(origin: newOrigin, size: frame.size)
    }
}
