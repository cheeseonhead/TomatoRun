//
//  SKNode+Position.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/11/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKNode {
    func layoutUsing(_ layout: (CGRect) -> CGRect) {
        let newFrame = layout(frame)
        position(atFrame: newFrame)
    }

    func position(atFrame newFrame: CGRect) {
        assert(newFrame.size == frame.size)

        let offset = newFrame.origin - frame.origin
        position = position + offset
    }
}
