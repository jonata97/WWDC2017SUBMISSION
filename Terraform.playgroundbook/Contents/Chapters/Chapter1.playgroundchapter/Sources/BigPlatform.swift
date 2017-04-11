import Foundation
import SpriteKit
import PlaygroundSupport


public class BigPlatform: SKSpriteNode {
    
    
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public init () {
        let color = UIColor()
        let texture = SKTexture(imageNamed: "bigPlatform.png")
        let size = CGSize(width: 330, height: 100)
        super.init(texture: texture, color: color, size: size)
        
        let textureBody = SKTexture(imageNamed: "bigPlatform.png")
        let bigPlatformBody = SKPhysicsBody(texture: textureBody, size: CGSize(width: 330, height: 100))
        bigPlatformBody.collisionBitMask = PhysicsCategory.Player
        bigPlatformBody.categoryBitMask = PhysicsCategory.World
        bigPlatformBody.contactTestBitMask = PhysicsCategory.World
        bigPlatformBody.affectedByGravity = false
        bigPlatformBody.isDynamic = false
        bigPlatformBody.friction = 0.6
        self.physicsBody = bigPlatformBody
        self.addParticle()
        
    }
    
    public func addParticle() {
        let emitter = SKEmitterNode(fileNamed: "Stone.sks")
        
        emitter?.position = self.position
        emitter?.name = "particle"
        emitter?.zPosition = -5
        
        // Send the particles to the scene.
        emitter?.targetNode = self;
        self.addChild(emitter!)
    }
    
    
}
