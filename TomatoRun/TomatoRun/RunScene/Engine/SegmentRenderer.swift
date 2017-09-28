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
            if let newSegment = SegmentManager.getNextSegment(forHeight: currentSegmentEnd) {
                addSegment(newSegment)
            }
        }
    }

    func addSegment(_ segment: Segment) {
        var result = getHeightsAndRopes(segment.woodenBoards)
        scene.addBoards(atHeights: result.heights, ropeIndex: result.ropes)

        result = getHeightsAndRopes(segment.spiders)
        scene.addSpiders(atHeights: result.heights, ropeIndex: result.ropes)

        currentSegmentEnd += segment.length
    }
}

// MARK: Adding entities
private extension SegmentRenderer {
    func getHeightsAndRopes(_ entities: [Ropable]) -> (heights: [CGFloat], ropes: [Int]) {
        var heights = [CGFloat]()
        var rope = [Int]()

        entities.forEach { entity in
            heights.append(entity.height + currentSegmentEnd)
            rope.append(entity.rope)
        }

        return (heights, rope)
    }
}
