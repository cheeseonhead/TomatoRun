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
            return result.positioned(edge: .minYEdge, at: anchor.positionForEdge(.maxYEdge))
        }
        }
    }

    // MARK: - Pure

    static func belowCentered(_ anchor: CGRect) -> Layout {
        return { frame in
            frame.positioned(anchorType: .topMiddle, at: anchor.positionFor(anchorType: .bottomMiddle))
        }
    }

    static func centered(at anchor: CGRect) -> Layout {
        return { frame in
            frame.positioned(anchorType: .center, at: anchor.positionFor(anchorType: .center))
        }
    }

    static func positioned(anchor: CGPoint, at point: CGPoint) -> Layout {
        return { frame in
            frame.positioned(anchor: anchor, at: point)
        }
    }

    static func positioned(anchorType type: PointType, at point: CGPoint) -> Layout {

        return { frame in
            frame.positioned(anchorType: type, at: point)
        }
    }
}

infix operator >==: AdditionPrecedence
// MARK: - Math
func >==(layout: @escaping Layout, f: @escaping (@escaping Layout) -> Layout) -> Layout {
    return f(layout)
}
