//
//  Positionable.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-13.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

protocol Positionable: Positional {
    func setPosition(_ position: CGPoint)
}
