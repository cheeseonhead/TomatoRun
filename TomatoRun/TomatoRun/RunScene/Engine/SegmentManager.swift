//
//  SegmentManager.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

let numberOfSegments = 4
var segmentIndex = 0

class SegmentManager {

    static func getNextSegment(forHeight height: CGFloat) -> Result<Segment> {
        return levelNumber(forHeight: height) ==> LevelFileParser.getLevel ==> chooseSegment
    }

    static func levelNumber(forHeight _: CGFloat) -> Result<Int> {
        let levelNum = Int.random(min: 1, max: 3)
        return .success(Box(levelNum))
    }

    static let chooseSegment: (Level) -> Result<Segment> = { level in
        guard level.count > 0 else { return .failure("Level is empty") }

        return .success(Box(level[0]))
    }
}
