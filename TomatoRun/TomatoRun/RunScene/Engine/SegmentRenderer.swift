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
    var currentSegmentEnd = CGFloat(0)

    init(scene: RunScene) {
        self.scene = scene
    }

    func update(_: TimeInterval) {
        guard let renderedFrame = scene.camera?.renderedFrame() else { return }

        let maxY = renderedFrame.position(forType: .topRight).y
        while currentSegmentEnd < maxY + renderBuffer {
            if let newSegment = segmentManager.getNextSegment() {
                addSegment(newSegment)
            }
        }
    }

    func addSegment(_ segment: Segment) {
        var heights = [CGFloat]()
        var rope = [Int]()

        for board in segment.woodenBoards {
            heights.append(currentSegmentEnd + board.height)
            rope.append(board.rope)
        }

        scene.addBoards(atHeights: heights, ropeIndex: rope)
        currentSegmentEnd += segment.length
    }
}
