//
//  TextLabelComponent.swift
//  TomatoRun
//
//  Created by Andy Sheng on 2017-09-29.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit
import GameplayKit

class TextLabelComponent: GKComponent, Spriteful {

    unowned let worldNode: SKNode
    let anchor: CGPoint
    var node: TextLabelNode

    private var previousAnchorPoint: CGPoint?

    init(text: String, anchor: CGPoint, worldNode: SKNode) {
        node = TextLabelNode(text: text, fontSize: .Large)
        self.anchor = anchor
        self.worldNode = worldNode

        self.worldNode.addChild(node)

        super.init()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func update(deltaTime _: TimeInterval) {
        guard let spriteComponent = entity?.component(ofType: SpriteComponent.self) else { return }

        let anchorPoint = spriteComponent.node.frame.position(forAnchor: anchor)

        guard anchorPoint != previousAnchorPoint else { return }
        previousAnchorPoint = anchorPoint

        node.position(anchor: CGPoint(x: 0.5, y: 0), at: anchorPoint)
    }

    func removeFromParent() {
        node.removeFromParent()
    }
}
