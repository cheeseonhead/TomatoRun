//
//  TouchComponent.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-11.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class TouchComponent: GKComponent {
    var touched: Bool = false

    override func update(deltaTime _: TimeInterval) {
        touched = false
    }
}
