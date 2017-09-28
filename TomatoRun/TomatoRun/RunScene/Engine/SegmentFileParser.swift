//
//  SegmentFileParser.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

private let levelFileVersion = "v1"

class LevelFileParser {
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
extension LevelFileParser {
    func urlString(forFile fileName: String) -> Result<URL> {
        guard let urlString = Bundle.main.path(forResource: "\(fileName)_\(levelFileVersion)", ofType: "json") else {
            return .failure("Could not create URL from: \(fileName)")
        }

        let url = URL(fileURLWithPath: urlString)
        return .success(Box(url))
    }

    func jsonDataFrom(_ url: URL) -> Result<Data> {
        guard let jsonData = try? Data(contentsOf: url) else {
            return .failure("Could not get JSON Data")
        }

        return .success(Box(jsonData))
    }

    func decoderFrom<T: Decodable>(_ type: T.Type, decoder: JSONDecoder) -> (Data) -> Result<T> {
        return { jsonData in
            guard let t = try? decoder.decode(type, from: jsonData) else { return .failure("Cannot parse \(T) object") }

            return .success(Box(t))
        }
    }
}
