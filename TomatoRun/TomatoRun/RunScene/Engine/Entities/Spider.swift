//
//  Spider.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

struct Spider: Ropable, Codable {
    var heightRatio: CGFloat
    var rope: Int

    enum CodingKeys: String, CodingKey {
        case heightRatio = "height_ratio"
        case rope
    }
}
