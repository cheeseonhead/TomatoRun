//
//  SegmentManager.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

let numberOfSegments = 1

class SegmentManager {
    let segmentFileParser = SegmentFileParser()

    func getNextSegment() -> Segment? {
        return segmentFileParser.getSegment(number: 1)
    }
}
