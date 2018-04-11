//
//  RunPresentable.swift
//  TomatoRun
//
//  Created by Cheese Onhead on 9/23/17.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

protocol RunPresentable {
    var runViewController: RunViewController? { get set }
    var gameStateMachine: GameStateMachine! { get set }
}
