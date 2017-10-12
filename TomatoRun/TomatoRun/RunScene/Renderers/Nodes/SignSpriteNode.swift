//
//  SignSpriteNode.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 10/12/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class SignSpriteNode: SKSpriteNode {

    var bodyFrame: CGRect {
        return signBody.frame
    }

    private let signBody: SKShapeNode

    override init(texture _: SKTexture?, color: UIColor, size: CGSize) {
        signBody = SKShapeNode(rectOf: size)

        super.init(texture: nil, color: color, size: size)

        signBody.fillColor = color
        addChild(signBody)
    }

    convenience init(color: UIColor, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
