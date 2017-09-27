//
//  QuickCheck.swift
//  TomatoRunTests
//
//  Created by Jeffrey Wu on 2017-09-27.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

protocol Arbitrary {
    static func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}
