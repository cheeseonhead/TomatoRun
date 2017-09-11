//
//  SegmentRenderer.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class SegmentRenderer {
    let segmentManager = SegmentManager()

    unowned let scene: RunScene

    init(scene: RunScene) {
        self.scene = scene
    }
}
