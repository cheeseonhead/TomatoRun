//
//  CGRect+Math.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/13/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

extension CGRect {
    init(minX: CGFloat, minY: CGFloat, maxX: CGFloat, maxY: CGFloat) {
        let orig = CGPoint(x: minX, y: minY)
        let sz = CGSize(width: maxX - minX, height: maxY - minY)
        self.init(origin: orig, size: sz)
    }

    static func + (l: CGRect, r: CGRect) -> CGRect {
        let minX = min(l.positionFor(edge: .minXEdge), r.positionFor(edge: .minXEdge))
        let minY = min(l.positionFor(edge: .minYEdge), r.positionFor(edge: .minYEdge))
        let maxX = max(l.positionFor(edge: .maxXEdge), r.positionFor(edge: .maxXEdge))
        let maxY = max(l.positionFor(edge: .maxYEdge), r.positionFor(edge: .maxYEdge))

        return CGRect(minX: minX, minY: minY, maxX: maxX, maxY: maxY)
    }
}
