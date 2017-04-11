import Foundation

import Foundation
import SpriteKit
import PlaygroundSupport


public class Engine: SKSpriteNode {
    private var emitter = SKEmitterNode(fileNamed: "Smoke.sks")
    var animation = [SKTexture]()
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init () {
        
        let color = UIColor()
        let texture = SKTexture()
        let size = CGSize(width: 160, height: 160)
        super.init(texture: texture, color: color, size: size)
        self.name = "engine"
        let textureBody = SKTexture()
        self.texture = textureBody
        let body = SKPhysicsBody(rectangleOf: self.size)
        emitter = SKEmitterNode(fileNamed: "Smoke.sks")
        body.collisionBitMask = PhysicsCategory.Item
        body.categoryBitMask = PhysicsCategory.Item
        body.contactTestBitMask = PhysicsCategory.Player
        body.affectedByGravity = false
        body.isDynamic = false
        body.usesPreciseCollisionDetection = true
        self.physicsBody = body
        self.settingAnimation()
        self.animationEngine()
        
    }
    
    
    public func settingAnimation () {
        
        var animationFrames = [SKTexture]()
        
        
        for i in 0...87 {
            let theMachineTexture = "theMachine\(i)"
            animationFrames.append(SKTexture(imageNamed: theMachineTexture))
        }
        
        
        self.animation = animationFrames
    }
    
    public func animationEngine() {
        
        
        self.run(SKAction.animate(with: self.animation,
                                  timePerFrame: 0.1,
                                  resize: false,
                                  restore: true),
                 withKey:"animationEngine")
        
    }
    
    
    
}
