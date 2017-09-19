//
//  SegmentManager.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

let numberOfSegments = 1
let maxNumberOfSegments = 4
var segmentIndex = 0

class SegmentManager {
    let segmentFileParser = SegmentFileParser()

    func getNextSegment() -> Segment? {
        if segmentIndex>maxNumberOfSegments {
            segmentIndex=0
        }
        segmentIndex+=1
        return segmentFileParser.getSegment(number: segmentIndex)
    }
}
