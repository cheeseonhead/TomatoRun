//
//  CGRect+Position.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

typealias Layout = (CGRect) -> CGRect

extension CGRect {

    // MARK: - Composite

    static func offsetted(by vector: CGVector) -> (@escaping Layout) -> Layout {
        return { layout in { frame in
            let result = layout(frame)
            let newOrigin = result.origin + vector

            return CGRect(origin: newOrigin, size: frame.size)
        }
        }
    }

    static func above(frame anchor: CGRect) -> (@escaping Layout) -> Layout {
        return { layout in { frame in
            let result = layout(frame)
            return result.positioned(edge: .minYEdge, at: anchor.position(forEdge: .maxYEdge))
        }
        }
    }

    // MARK: - Pure

    static func positioned(anchor: CGPoint, at point: CGPoint) -> Layout {
        return { frame in
            let offset = point - frame.position(forAnchor: anchor)
            let newOrigin = frame.origin + offset

            return CGRect(origin: newOrigin, size: frame.size)
        }
    }

    static func positioned(anchorType type: PointType, at point: CGPoint) -> Layout {

        return { frame in
            let anchorPoint = CGRect.anchor(forType: type)

            return positioned(anchor: anchorPoint, at: point)(frame)
        }
    }
}

infix operator >==: AdditionPrecedence
// MARK: - Math
func >==(layout: Layout, f: @escaping (Layout) -> Layout) -> Layout {
    return f(layout)
}
