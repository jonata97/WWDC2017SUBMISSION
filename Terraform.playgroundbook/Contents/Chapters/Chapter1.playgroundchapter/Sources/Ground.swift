import Foundation
import SpriteKit
import PlaygroundSupport


public class Ground: SKSpriteNode {
    
    
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public init (imageNamed: String) {
        let color = UIColor()
        let texture = SKTexture(imageNamed: imageNamed)
        let size = CGSize(width: 32, height: 32)
        super.init(texture: texture, color: color, size: size)
 
        //physics

        let body = SKPhysicsBody(rectangleOf: size)
        body.friction = 0.6
        body.collisionBitMask = PhysicsCategory.Player
        body.categoryBitMask = PhysicsCategory.World
        body.contactTestBitMask = PhysicsCategory.World
        body.affectedByGravity = false
        body.isDynamic = false
        self.physicsBody = body
        self.color = UIColor(colorLiteralRed: 15, green: 33, blue: 44, alpha: 100)
    }
    
    
    
}
