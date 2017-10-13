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

        let maxY = renderedFrame.positionFor(anchorType: .topRight).y
        while currentSegmentEnd < maxY + renderBuffer {
            let result = segmentManager.getNextSegment(forHeight: currentSegmentEnd)

            switch result {
            case let .failure(str):
                print(str)
            default: break
            }

            result ==> { newSegment -> Void in
                self.addSegment(newSegment)
            }
        }
    }

    func addSegment(_ segment: Segment) {
        let infos = Segment.infoFor(segment)
        let offset = offsetHeight(currentSegmentEnd)

        let boardInfos = segment.woodenBoards => infos => offset
        scene.addBoards(boardInfos)

        let spiderInfos = segment.spiders => infos => offset
        scene.addSpiders(spiderInfos)

        currentSegmentEnd += segment.length
    }

    func offsetHeight(_ offset: CGFloat) -> (CGFloat, Int, Bool) -> (CGFloat, Int, Bool) {
        return { height, index, hasText in
            (height + offset, index, hasText)
        }
    }
}
