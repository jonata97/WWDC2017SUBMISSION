import Foundation

import Foundation
import SpriteKit
import PlaygroundSupport


public class Crystal: SKSpriteNode {
    
    
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    init (imageNamed: String) {
        let color = UIColor()
        let texture = SKTexture(imageNamed: imageNamed)
        let size = CGSize(width: 60, height: 60)
        super.init(texture: texture, color: color, size: size)
        self.name = "crystal"
        let textureBody = SKTexture(imageNamed: imageNamed)
        self.texture = textureBody
        let body = SKPhysicsBody(texture: textureBody, size: CGSize(width: 60, height: 60))
        body.collisionBitMask = PhysicsCategory.Item
        body.categoryBitMask = PhysicsCategory.Item
        body.contactTestBitMask = PhysicsCategory.Player
        body.affectedByGravity = false
        body.isDynamic = false
        body.usesPreciseCollisionDetection = true
        self.physicsBody = body
        
    }
    
    
    
}
