//
//  CGVector+Size.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

extension CGVector {
    func size() -> CGSize {
        return CGSize(width: dx, height: dy)
    }
}
