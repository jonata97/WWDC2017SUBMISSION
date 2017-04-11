import Foundation
import SpriteKit
import PlaygroundSupport


public class Empty: SKSpriteNode {
    
    
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public init () {
        let color = UIColor()
        let texture = SKTexture()
        let size = texture.size()
        super.init(texture: texture, color: color, size: size)
        self.name = "Empty"
        
        
    }
    
    
    
}
