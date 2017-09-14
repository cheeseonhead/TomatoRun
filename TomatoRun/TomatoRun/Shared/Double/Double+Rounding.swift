//
//  Double+Rounding.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/13/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension Double {
    func roundedToInt(_ rule: FloatingPointRoundingRule) -> Int {
        return Int(rounded(rule))
    }
}
