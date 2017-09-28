//
//  Segment.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

struct Segment: Codable {
    var woodenBoards: [WoodenBoard]
    var spiders: [Spider]
    var length: CGFloat

    enum CodingKeys: String, CodingKey {
        case woodenBoards = "wooden_boards"
        case length
        case spiders
    }
}

extension Segment {

    static func infoFor(_ segment: Segment) -> (Ropable) -> (CGFloat, Int) {
        return { ropable in
            (segment.length * ropable.heightRatio, ropable.rope)
        }
    }
}
