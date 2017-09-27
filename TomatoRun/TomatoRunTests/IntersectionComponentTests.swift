//
//  IntersectionComponentTests.swift
//  TomatoRunTests
//
//  Created by Jeffrey Wu on 2017-09-27.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import XCTest
@testable import TomatoRun

class IntersectionComponentTests: XCTestCase {
}

// MARK: - ComponentFilter by intersection works
extension IntersectionComponentTests {

    func testComponentPassesGenericFilter() {
        let intersectionFilter = intersection(equalTo: CGPoint.zero)
        let targetComponent = IntersectionComponent(anchors: [])
        targetComponent.intersections = [CGPoint.zero, CGPoint(x: 0, y: 100), CGPoint(x: 50, y: -100)]

        let componentFilter = IntersectionComponent.component(filter: intersectionFilter)

        XCTAssertTrue(componentFilter(targetComponent))
    }

    func testComponentFailsGenericFilter() {
        let intersectionFilter = intersection(equalTo: CGPoint.zero)
        let targetComponent = IntersectionComponent(anchors: [])
        targetComponent.intersections = [CGPoint(x: 0, y: 100), CGPoint(x: 50, y: -100)]

        let componentFilter = IntersectionComponent.component(filter: intersectionFilter)

        XCTAssertFalse(componentFilter(targetComponent))
    }

    func intersection(equalTo curPoint: CGPoint) -> IntersectionComponent.IntersectionFilter {
        return { intersection in
            intersection == curPoint
        }
    }
}

// MARK: - aHeadOf works
extension IntersectionComponentTests {

    func testIntersectionIsAhead() {
        XCTAssertTrue(aheadIsCorrect(CGPoint.zero, intersection: CGPoint(x: 0, y: 100)))
    }

    func testIntersectionIsNotAhead() {
        XCTAssertTrue(aheadIsCorrect(CGPoint.zero, intersection: CGPoint(x: 0, y: 0)))
    }

    func testIntersectionIsBehind() {
        XCTAssertTrue(aheadIsCorrect(CGPoint.zero, intersection: CGPoint(x: 0, y: -100)))
    }

    func aheadIsCorrect(_ curPosition: CGPoint, intersection: CGPoint) -> Bool {
        let filter = IntersectionComponent.intersection(aheadOf: curPosition)

        return filter(intersection) == (curPosition.y < intersection.y)
    }
}

// MARK: - onPathOf works
extension IntersectionComponentTests {

    func testIntersectionIsOnPath() {
        XCTAssertTrue(onPathIsCorrect(CGPoint.zero, intersection: CGPoint(x: 0, y: 100)))
    }

    func testIntersectionIsNotOnPath() {
        XCTAssertTrue(onPathIsCorrect(CGPoint.zero, intersection: CGPoint(x: 100, y: 100)))
    }

    func onPathIsCorrect(_ curPosition: CGPoint, intersection: CGPoint) -> Bool {
        let filter = IntersectionComponent.intersection(onPathOf: curPosition)

        return filter(intersection) == (curPosition.x == intersection.x)
    }
}
