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
    let segmentFileParser = LevelFileParser()

    func getNextSegment() -> Segment? {
        segmentIndex = (segmentIndex + 1) % numberOfSegments
        return segmentFileParser.getSegment(number: segmentIndex)
    }
}
