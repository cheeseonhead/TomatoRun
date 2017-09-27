//
// Created by Jeffrey Wu on 2017-09-02.
// Copyright (c) 2017 okAy Studios. All rights reserved.
//

import GameplayKit

class IntersectionComponent: GKComponent {
    let intersectAnchors: [CGPoint]

    var intersections = [CGPoint]()
    var entityPosition = CGPoint(x: 0, y: 0)
    var previousFrame: CGRect?
    var canBreak: Bool = true

    init(anchors: [CGPoint]) {
        intersectAnchors = anchors

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime seconds: TimeInterval) {
        super.update(deltaTime: seconds)

        guard let frame = entity?.frame(), frame != previousFrame else {
            return
        }
        previousFrame = frame

        intersections = [CGPoint]()
        for anchor in intersectAnchors {
            let anchorPosition = frame.position(forAnchor: anchor)

            intersections.append(anchorPosition)
        }
    }

    func pathToTravel(withStarting startingIntersection: CGPoint) -> [CGPoint] {
        if startingIntersection == intersections[intersections.startIndex] {
            return intersections
        } else if startingIntersection == intersections[intersections.endIndex - 1] {
            return intersections.reversed()
        }
        return []
    }
}

// MARK: - IntersectionComponent Filters
extension IntersectionComponent {
    typealias ComponentFilter = (IntersectionComponent) -> Bool

    // MARK: Derived
    static func component(aheadAndOnPathOf curPosition: CGPoint) -> ComponentFilter {
        return filterUnion(component(aheadOf: curPosition), component(onPathOf: curPosition))
    }

    // MARK: Primitives
    static func component(aheadOf curPosition: CGPoint) -> ComponentFilter {
        return component(filter: IntersectionComponent.intersection(aheadOf: curPosition))
    }

    static func component(onPathOf curPosition: CGPoint) -> ComponentFilter {
        return component(filter: IntersectionComponent.intersection(onPathOf: curPosition))
    }

    // MARK: Generic
    static func component(filter: @escaping IntersectionComponent.IntersectionFilter) -> ComponentFilter {
        return { component in
            component.intersections.reduce(false) { $0 || filter($1) }
        }
    }
}

// MARK: - Intersection Filters
extension IntersectionComponent {
    typealias IntersectionFilter = (_ intersection: CGPoint) -> Bool

    // MARK: Primitives
    static func intersection(aheadOf curPosition: CGPoint) -> IntersectionFilter {
        return { intersection in
            intersection.y > curPosition.y
        }
    }

    static func intersection(onPathOf curPosition: CGPoint) -> IntersectionFilter {
        return { intersection in
            let roundedIntersectX = intersection.x.rounded(.toNearestOrAwayFromZero)
            let roundedPositionX = curPosition.x.rounded(.toNearestOrAwayFromZero)

            return roundedPositionX == roundedIntersectX
        }
    }
}
