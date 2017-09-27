//
//  CGRect+Rounding.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-27.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension CGRect {

    func rounded(_ rule: FloatingPointRoundingRule) -> CGRect {
        return CGRect(x: minX.rounded(rule), y: minY.rounded(rule),
                      width: width.rounded(rule), height: height.rounded(rule))
    }
}
