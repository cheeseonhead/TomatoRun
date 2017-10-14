//
//  CGSize+Point.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

extension CGSize {
    func point() -> CGPoint {
        return CGPoint(x: width, y: height)
    }
}
