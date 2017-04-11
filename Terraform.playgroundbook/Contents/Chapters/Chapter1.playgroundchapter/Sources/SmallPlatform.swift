import Foundation
import SpriteKit
import PlaygroundSupport


public class SmallPlatform: SKSpriteNode {
    
    
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public init (position: CGPoint) {
        let color = UIColor()
        let texture = SKTexture(imageNamed: "smallPlatformWithGrass.png")
        let size = texture.size()
        super.init(texture: texture, color: color, size: size)
        
        let textureBody = SKTexture(imageNamed: "smallPlatform.png")
        let smallPlatformBody = SKPhysicsBody(texture: textureBody, size: textureBody.size())
        self.size = CGSize(width: 128, height: 96)
        smallPlatformBody.collisionBitMask = PhysicsCategory.Player
        smallPlatformBody.categoryBitMask = PhysicsCategory.World
        smallPlatformBody.contactTestBitMask = PhysicsCategory.World
        smallPlatformBody.affectedByGravity = false
        smallPlatformBody.isDynamic = false
        smallPlatformBody.friction = 0.6
        self.physicsBody = smallPlatformBody
        
        if (position.y > 0) {
            self.addParticle()
        }
        
        
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
