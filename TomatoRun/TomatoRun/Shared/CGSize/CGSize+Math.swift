//
//  CGSize+Math.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import UIKit

func pointWise(_ f: (CGFloat, CGFloat) -> CGFloat, l: CGSize, r: CGSize) -> CGSize {
    return CGSize(width: f(l.width, r.width), height: f(l.height, r.height))
}

func -(l: CGSize, r: CGSize) -> CGSize {
    return pointWise(-, l: l, r: r)
}

func *(scale: CGFloat, r: CGSize) -> CGSize {
    return CGSize(width: scale * r.width, height: scale * r.height)
}

func *(l: CGSize, r: CGSize) -> CGSize {
    return pointWise(*, l: l, r: r)
}

func /(l: CGSize, r: CGSize) -> CGSize {
    return pointWise(/, l: l, r: r)
}

func isHorizontalEdge(_ edge: CGRectEdge) -> Bool {
    switch edge {
    case .maxXEdge, .minXEdge:
        return true
    default:
        return false
    }
}

func splitRect(rect: CGRect, sizeRatio: CGSize, edge: CGRectEdge) -> (CGRect, CGRect) {
    let ratio = isHorizontalEdge(edge) ? sizeRatio.width : sizeRatio.height
    let multiplier = isHorizontalEdge(edge) ? rect.width : rect.height
    let distance = multiplier * ratio

    return rect.divided(atDistance: distance, from: edge)
}

func splitHorizontal(_ rect: CGRect, ratio: CGSize) -> (CGRect, CGRect) {
    return splitRect(rect: rect, sizeRatio: ratio, edge: .minXEdge)
}

func splitVertical(_ rect: CGRect, ratio: CGSize) -> (CGRect, CGRect) {
    return splitRect(rect: rect, sizeRatio: ratio, edge: .minYEdge)
}
