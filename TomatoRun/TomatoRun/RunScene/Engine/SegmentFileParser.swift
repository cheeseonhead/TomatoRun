//
//  SegmentFileParser.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

private let levelFileVersion = "v1"

class SegmentFileParser {
    let decoder = JSONDecoder()

    func getSegment(number: Int) -> Segment? {
        return parseFile(named: "level\(number)")
    }

    func parseFile(named name: String) -> Segment? {
        if let url = url(forFile: name),
            let jsonData = try? Data(contentsOf: url),
            let segment = try? decoder.decode(Segment.self, from: jsonData) {
            return segment
        }

        return nil
    }
}

// MARK: Helpers
extension SegmentFileParser {
    func url(forFile fileName: String) -> URL? {
        if let urlString = Bundle.main.path(forResource: "\(fileName)_\(levelFileVersion)", ofType: "json") {
            return URL(fileURLWithPath: urlString)
        }

        return nil
    }
}
