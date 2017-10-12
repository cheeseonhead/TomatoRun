//
//  Diagram.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit
import CoreGraphics

enum Primitive {
    case Rectangle
}

enum Attribute {
    case FillColor(UIColor)
}

indirect enum Diagram {
    case Prim(CGSize, Primitive)
    case Beside(Diagram, Diagram)
    case Rotate(CGFloat, Diagram)
    case Attributed(Attribute, Diagram)
}

extension Diagram {
    func size() -> CGSize {
        switch self {
        case let .Prim(size, _):
            return size
        case let .Attributed(_, x):
            return x.size()
        case let .Beside(l, r):
            let sizeL = l.size()
            let sizeR = r.size()
            return CGSize(width: sizeL.width + sizeR.width, height: max(sizeL.height, sizeR.height))
        case let .Rotate(_, x):
            return x.size()
        }
    }
}

func fit(alignment: CGVector, inputSize: CGSize, rect: CGRect) -> CGRect {
    let scaleSize = rect.size / inputSize
    let scale = min(scaleSize.width, scaleSize.height)
    let size = scale * inputSize
    let space = alignment.size() * (size - rect.size)
    return CGRect(origin: rect.origin - space.point(), size: size)
}

func draw(context: CGContext, bounds: CGRect, diagram: Diagram) {
    switch diagram {
    case let .Prim(size, .Rectangle):
        let frame = fit(alignment: CGVector(dx: 0.5, dy: 0.5), inputSize: size, rect: bounds)
        context.fill(frame)
    case let .Attributed(.FillColor(color), d):
        context.saveGState()
        color.set()
        draw(context: context, bounds: bounds, diagram: d)
        context.restoreGState()
    case let .Beside(l, r):
        let (lFrame, rFrame) = splitHorizontal(bounds, ratio: l.size() / diagram.size())
        draw(context: context, bounds: lFrame, diagram: l)
        draw(context: context, bounds: rFrame, diagram: r)
    case let .Rotate(degree, d):
        context.rotate(by: degree)
        draw(context: context, bounds: bounds, diagram: d)
        context.rotate(by: -degree)
    }
}
