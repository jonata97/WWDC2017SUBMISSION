import Foundation
import SpriteKit
import PlaygroundSupport


public class Spikes: SKSpriteNode {
    
    var lavaGlow = [SKTexture]()
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public init () {
        let color = UIColor()
        let texture = SKTexture(imageNamed:"spikes.png")
        let size = texture.size()
        super.init(texture: texture, color: color, size: size)
        self.name = "spikes"
        
        let body = SKPhysicsBody(rectangleOf: self.size)
        body.friction = 0.6
        body.collisionBitMask = PhysicsCategory.Player //check if i remove this, then the character doesnt bounces off the tile
        body.categoryBitMask = PhysicsCategory.Danger
        body.contactTestBitMask = PhysicsCategory.Player
        body.affectedByGravity = false
        body.isDynamic = false
        self.physicsBody = body
        self.color = UIColor(colorLiteralRed: 15, green: 33, blue: 44, alpha: 100)
        self.addParticle()
        

    }
    
    public func addParticle() {
        let emitter = SKEmitterNode(fileNamed: "yellowFog.sks")
        
        emitter?.position = self.position
        emitter?.position.y = self.position.y+15
        emitter?.name = "particle"
        emitter?.zPosition = 10
        
        // Send the particles to the scene.
        emitter?.targetNode = self;
        self.addChild(emitter!)
    }


    
    
}
