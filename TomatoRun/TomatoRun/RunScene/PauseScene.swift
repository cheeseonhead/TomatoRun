//
//  PauseScene.swift
//  TomatoRun
//
//  Created by Jeffrey Wu on 2017-09-20.
//  Copyright © 2017 okAy Studios. All rights reserved.
//

import SpriteKit

class PauseScene: SKSpriteNode {

    unowned let runScene: RunScene

    let resumeLabel: SKLabelNode

    init(size: CGSize, scene: RunScene) {
        runScene = scene
        resumeLabel = SKLabelNode(text: "Resume")

        super.init(texture: nil, color: .brown, size: size)

        isUserInteractionEnabled = true
        alpha = 0.5

        resumeLabel.position = CGPoint(x: 0, y: 0)

        addChild(resumeLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with _: UIEvent?) {
        guard let touch = touches.first, let scene = scene else { return }

        let touchedNodes = scene.nodes(at: touch.location(in: scene))

        if touchedNodes.contains(resumeLabel), runScene.gameStateMachine.canEnterState(GamePlayingState.self) {
            runScene.gameStateMachine?.enter(GamePlayingState.self)
        }
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
