//
//  Ropable.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

protocol Ropable {
    var heightRatio: CGFloat { get }
    var rope: Int { get }
    var hasText: Bool? { get }
}
