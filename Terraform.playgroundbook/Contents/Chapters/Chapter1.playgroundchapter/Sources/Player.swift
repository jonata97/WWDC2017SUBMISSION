import Foundation
import SpriteKit
import PlaygroundSupport



public class Player:SKSpriteNode {
    
    
    
    var velocity = CGPoint (x: 0.0, y: 0.0)
    var idle = [SKTexture]()
    var fly = [SKTexture]()
    var tp = [SKTexture]()
    
    
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        
        
    }
    
    
    init () {
        //create player with the image
        let color = UIColor()
        let texture = SKTexture()
        let size = CGSize(width: 60, height: 80)
        super.init(texture: texture, color: color, size: size)
        let body = SKPhysicsBody(rectangleOf: CGSize(width: self.size.width, height: 80))
        body.friction = 0.3
        body.collisionBitMask = PhysicsCategory.World | PhysicsCategory.Danger
        body.categoryBitMask = PhysicsCategory.Player
        body.contactTestBitMask = PhysicsCategory.Item | PhysicsCategory.Danger
        body.isDynamic = true;
        body.allowsRotation = false;
        body.mass = CGFloat(1)
        self.physicsBody = body
        self.settingAnimation()
        
        
        
    }
    
    public func settingAnimation () {
        
        var idleFrames = [SKTexture]()
        
        
        for i in 0...13 {
            let astronautTexture = "astronaut\(i)"
            idleFrames.append(SKTexture(imageNamed: astronautTexture))
        }
        
        var flyFrames = [SKTexture]()
        
        
        for i in 0...9 {
            let astronautFlyTexture = "astronautFly\(i)"
            flyFrames.append(SKTexture(imageNamed: astronautFlyTexture))
            
        }
        
        var tpFrames = [SKTexture]()
        
        
        for i in 0...18 {
            let playerTpTexture = "playerTp\(i)"
            tpFrames.append(SKTexture(imageNamed: playerTpTexture))
            
        }
        
        
        self.idle = idleFrames
        self.fly = flyFrames
        self.tp = tpFrames
    }
    
    public func idlePlayer() {
        
        
        self.run(SKAction.repeatForever(
            SKAction.animate(with: self.idle,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"playerIdle")
        self.size.height = 80
    }
    
    
    public func flyPlayer() {
        self.run(SKAction.repeatForever(
            SKAction.animate(with: self.fly,
                             timePerFrame: 0.1,
                             resize: false,
                             restore: true)),
                 withKey:"playerFly")
        self.size.height = 120
    }
    
    
    public func tpPlayer(withCompletion completion: @escaping () -> Void) {
        let action = SKAction.animate(with: self.tp,
                                      timePerFrame: 0.1,
                                      resize: false,
                                      restore: true)
        self.run(action, completion: completion)
    }
    
    
    
    
}


