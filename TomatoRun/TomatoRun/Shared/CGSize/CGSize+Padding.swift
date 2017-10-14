//
//  CGSize+Padding.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension CGSize {
    func addedPadding(_ padding: CGFloat) -> CGSize {
        return addedInsets(UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding))
    }

    func addedInsets(_ inset: UIEdgeInsets) -> CGSize {
        return CGSize(width: width + inset.left + inset.right, height: height + inset.top + inset.bottom)
    }
}
