//
//  Dodgeball.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 29/10/22.
//

import SwiftUI
import SpriteKit

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        createBall(position: location)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        createBall(position: location)
    }
    
    private func createBall(position: CGPoint) {
        let ball = SKSpriteNode(imageNamed: "dodgeBall")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.7)
        ball.physicsBody?.restitution = 0.4
        ball.position = position
        addChild(ball)
    }
}

struct Dodgeball: View {
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: UIScreen.main.bounds.size.width,
                            height: UIScreen.main.bounds.size.height)
        return scene
    }
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.black, .white.opacity(0.8), .black]),
                           startPoint: .top,
                           endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
            VStack {
                SpriteView(scene: scene)
                    .frame(width: 320, height: 650)
            }
        }
    }
}

struct Dodgeball_Previews: PreviewProvider {
    static var previews: some View {
        Dodgeball()
    }
}
