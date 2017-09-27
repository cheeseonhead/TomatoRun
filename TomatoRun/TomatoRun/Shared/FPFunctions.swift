//
//  FPFunctions.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/27/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import Foundation

func filterUnion<T>(_ filter1: @escaping (T) -> Bool, _ filter2: @escaping (T) -> Bool) -> (T) -> Bool {
    return { item in
        filter1(item) && filter2(item)
    }
}

func chooseBest<T>(from set: Set<T>, compare: (T, T) -> T) -> T? {
    guard let first = set.first else { return nil }

    return set.reduce(first) { compare($0, $1) }
}
