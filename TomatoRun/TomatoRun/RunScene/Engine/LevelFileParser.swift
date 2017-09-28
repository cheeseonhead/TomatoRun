//
//  SegmentFileParser.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

private let levelFileVersion = "v1"
typealias Level = [Segment]

class LevelFileParser {
    let decoder = JSONDecoder()

    func getLevel(_ number: Int) -> Result<Level> {
        let decode = decoderFrom(Level.self, decoder: decoder)
        return fileName(for: number) ==> urlString ==> jsonDataFrom ==> decode
    }
}

// MARK: Helpers
extension LevelFileParser {
    func fileName(for levelNumber: Int) -> Result<String> {
        return .success(Box("level\(levelNumber)_\(levelFileVersion)"))
    }

    func urlString(forFile fileName: String) -> Result<URL> {
        guard let urlString = Bundle.main.path(forResource: fileName, ofType: "json") else {
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
            guard let t = try? decoder.decode(type, from: jsonData) else { return .failure("Cannot parse object") }

            return .success(Box(t))
        }
    }
}
