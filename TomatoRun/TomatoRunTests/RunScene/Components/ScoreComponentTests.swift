//
//  ScoreComponentTests.swift
//  TomatoRunTests
//
//  Created by Cheese Onhead on 1/4/18.
//  Copyright © 2018 okAy Studios. All rights reserved.
//

@testable import TomatoRun
import XCTest

class ScoreComponentTests: XCTestCase {
}

// MARK: - Zero InitialScore
extension ScoreComponentTests {

    func testZeroInitialScoreAndStarting() {
        let result = ScoreComponent.newScore(initialScore: 0, curY: 100, startYPosition: 0, scoreRate: 1)

        assert(result == 100)
    }

    func testZeroInitialScoreDifferentRate() {
        let result = ScoreComponent.newScore(initialScore: 0, curY: 100, startYPosition: 0, scoreRate: 0.5)

        assert(result == 50)
    }

    func testDifferentStartingPoint() {
        let result = ScoreComponent.newScore(initialScore: 0, curY: 100, startYPosition: 50, scoreRate: 1)

        assert(result == 50)
    }

    func testDifferentInitialScore() {
        let result = ScoreComponent.newScore(initialScore: 100, curY: 100, startYPosition: 0, scoreRate: 1)

        assert(result == 200)
    }
}
