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

struct Box<T> {
    let value: T
    init(_ value: T) {
        self.value = value
    }
}

enum Result<T> {
    case success(Box<T>)
    case failure(String)
}

infix operator ==>: AdditionPrecedence
func ==><T, U>(_ result: Result<T>, _ f: (T) -> Result<U>) -> Result<U> {
    switch result {
    case let .success(box):
        return f(box.value)
    case let .failure(str):
        return .failure(str)
    }
}

func ==><T>(_ result: Result<T>, _ f: @escaping (T) -> Void) -> Void {
    _ = result ==> { t -> Result<Bool> in
        f(t)
        return .success(Box(true))
    }
}
