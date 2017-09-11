//
//  Segment.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

struct Segment: Codable {
    var woodenBoards: [WoodenBoard]

    enum CodingKeys: String, CodingKey {
        case woodenBoards = "wooden_boards"
    }
}
