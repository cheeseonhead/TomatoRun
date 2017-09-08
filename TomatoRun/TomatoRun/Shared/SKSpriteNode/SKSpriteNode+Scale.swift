//
//  SKSpriteNode+Scale.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-08.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

extension SKSpriteNode
{
    func scale(toWidth width: CGFloat)
    {
        let ratio = size.height/size.width
        let newHeight = ratio * width
        
        size = CGSize(width: width, height: newHeight)
    }
}
