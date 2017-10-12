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
    static let numOfRopes = 4
    static let tomatoBottomPadding = CGFloat(250) // TomatoWidth
    static let tomatoSpeed = CGFloat(300)

    // MARK: Rates
    static let scoreRate = 1000.0 // Score per second

    // MARK: Misc
    static let scoreLength = 10

    enum ZPositions {
        static let uiZPosition = CGFloat(1100)
        static let tomato = CGFloat(1000)
        static let boards = CGFloat(900)
        static let spider = CGFloat(950)
        static let rope = CGFloat(500)
        static let pauseScene = CGFloat(1200)
        static let sidebar = CGFloat(300)
    }

    enum WidthRatio {
        static let pauseNode = CGFloat(0.1)
        static let ropeSpacing = CGFloat(0.9)
        static let spider = CGFloat(0.7)
        static let tomato = CGFloat(0.7)
    }

    enum Size {
        static let button = CGSize(width: 300.0, height: 90.0)
    }

    // MARK: Padding
    enum PaddingRatio {
        static let pauseNode = CGFloat(0.02)
        static let scoreLabel = pauseNode
    }

    enum Padding {
        static let buttonInside = CGFloat(30)
    }

    // MARK: Spacing
    enum Spacing {
        enum MainMenu {
            static let button = CGFloat(20)
        }
    }
}
