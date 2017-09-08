//
//  Array+Swap.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-08.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

extension Array
{
    mutating func swapAt(_ a: Int, _ b: Int)
    {
        let temp = self[a]
        self[a] = self[b]
        self[b] = temp
    }
}
