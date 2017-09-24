//
//  CGSize+Padding.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension CGSize {
    func addedPadding(_ padding: CGFloat) {
        return CGSize(width: width + (padding * 2), height: height + (padding * 2))
    }
}
