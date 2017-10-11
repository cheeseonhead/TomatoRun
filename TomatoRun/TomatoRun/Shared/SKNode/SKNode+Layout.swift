//
//  SKNode+Layout.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/7/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation
import SpriteKit

typealias Layout = (SKNode, SKNode) -> CGPoint

func ==>(layout: @escaping Layout, f: (@escaping Layout) -> Layout) -> Layout {
    return f(layout)
}

extension SKNode {

    func height() -> CGFloat {
        return frame.size.height
    }

    static func none() -> Layout {
        return { _, node in
            node.position
        }
    }
}

let belowCentered: Layout = SKNode.none() ==> below ==> centerHorizontally
let centered: Layout = SKNode.none() ==> centerHorizontally ==> centerVertically

func offset(_ offset: CGPoint) -> (@escaping Layout) -> Layout {
    return { layout in { anchor, node in
        let position = layout(anchor, node)
        return position + offset
    }
    }
}

func below(_ layout: @escaping Layout) -> Layout {
    return { anchor, node in
        let position = layout(anchor, node)
        let y = anchor.position.y - anchor.height() / 2 - node.height() / 2

        return CGPoint(x: position.x, y: y)
    }
}

func centerHorizontally(_ layout: @escaping Layout) -> Layout {
    return { anchor, node in
        let position = layout(anchor, node)

        return CGPoint(x: anchor.position.x, y: position.y)
    }
}

func centerVertically(_ layout: @escaping Layout) -> Layout {
    return { anchor, node in
        let position = layout(anchor, node)

        return CGPoint(x: position.x, y: anchor.position.y)
    }
}
