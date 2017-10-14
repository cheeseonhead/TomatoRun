//
//  WoodenBoard.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

struct WoodenBoard: Ropable, Codable {
    let heightRatio: CGFloat
    let rope: Int
    let hasText: Bool?

    enum CodingKeys: String, CodingKey {
        case heightRatio = "height_ratio"
        case rope
        case hasText
    }
}
