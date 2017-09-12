//
//  TouchComponent.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-11.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class TouchComponent: GKComponent {
    let handler: () -> Void

    init(handler: @escaping () -> Void) {
        self.handler = handler

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
