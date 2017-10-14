//
//  SegmentManager.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

let numberOfSegments = 4

class SegmentManager {

    var segmentCount = 0

    func getNextSegment(forHeight height: CGFloat) -> Result<Segment> {
        segmentCount += 1
        return SegmentManager.levelNumber(forHeight: height) ==> LevelFileParser.getLevel ==> SegmentManager.chooseSegment ==> shouldSegmentShowText
    }

    func shouldSegmentShowText(_ segment: Segment) -> Result<Segment> {
        var mutateSegment = segment
        if segmentCount == 1 {
            mutateSegment.showText = true
        }
        return .success(Box(mutateSegment))
    }

    static func levelNumber(forHeight _: CGFloat) -> Result<Int> {
        let levelNum = Int.random(min: 1, includingMax: 3)
        return .success(Box(levelNum))
    }

    static let chooseSegment: (Level) -> Result<Segment> = { level in
        guard level.count > 0 else { return .failure("Level is empty") }
        let segNum = Int.random(min: 0, includingMax: level.count - 1)
        return .success(Box(level[segNum]))
    }
}
