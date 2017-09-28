//
//  SegmentRenderer.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

private let renderBuffer = CGFloat(30)

class SegmentRenderer {
    let segmentManager = SegmentManager()
    unowned let scene: RunScene

    // MARK: State
    var currentSegmentEnd = CGFloat(400)

    init(scene: RunScene) {
        self.scene = scene
    }

    func update(_: TimeInterval) {
        guard let renderedFrame = scene.camera?.renderedFrame() else { return }

        let maxY = renderedFrame.position(forType: .topRight).y
        while currentSegmentEnd < maxY + renderBuffer {
            SegmentManager.getNextSegment(forHeight: currentSegmentEnd) ==> { newSegment -> Void in
                self.addSegment(newSegment)
            }
        }
    }

    func addSegment(_ segment: Segment) {
        let infosFor = Segment.infoFor(segment)

        let boardInfos = segment.woodenBoards.map(infosFor)
        scene.addBoards(boardInfos)

        let spiderInfos = segment.spiders.map(infosFor)
        scene.addSpiders(spiderInfos)

        currentSegmentEnd += segment.length
    }
}
