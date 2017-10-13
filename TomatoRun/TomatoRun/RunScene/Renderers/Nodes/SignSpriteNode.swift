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

    override var frame: CGRect {
        return signBody.frame + leg.frame
    }

    private let signBody: SKShapeNode
    private let leg: SKShapeNode

    override init(texture _: SKTexture?, color: UIColor, size: CGSize) {
        signBody = SKShapeNode(rectOf: size)
        leg = SKShapeNode(rectOf: CGSize(width: size.height * 0.3, height: size.height * 0.3))

        super.init(texture: nil, color: color, size: size)

        signBody.strokeColor = color
        signBody.fillColor = color
        leg.strokeColor = color
        leg.fillColor = color
        leg.zPosition = signBody.zPosition
        leg.zRotation = π / 4

        let signBodyBottomCenter = signBody.frame.positionFor(anchorType: .bottomMiddle)
        let legLayout = CGRect.positioned(anchorType: .center, at: signBodyBottomCenter) >== CGRect.offsetted(by: CGVector(dx: 0, dy: 2))

        leg.layoutUsing(legLayout)
        addChildren([signBody, leg])
    }

    convenience init(color: UIColor, size: CGSize) {
        self.init(texture: nil, color: color, size: size)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
