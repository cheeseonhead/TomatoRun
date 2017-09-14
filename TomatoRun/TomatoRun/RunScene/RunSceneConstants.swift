//
//  RunSceneConstants.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/10/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

enum RunSceneConstants {

    // MARK: Main Scene
    static let NumOfRopes = 4
    static let TomatoWidth = CGFloat(150)
    static let TomatoBottomPadding = TomatoWidth

    // MARK: Rates
    static let ScoreRate = 1000.0 // Score per second

    enum ZPositions {
        static let UIZPosition = CGFloat(1100)
        static let Tomato = CGFloat(1000)
        static let Boards = CGFloat(900)
        static let Spider = CGFloat(950)
        static let Rope = CGFloat(500)
    }

    enum FittingWidthRatio {
        static let PauseNode = CGFloat(0.1)
    }

    enum PaddingRatio {
        static let PauseNode = CGFloat(0.02)
        static let ScoreLabel = PauseNode
    }
}
