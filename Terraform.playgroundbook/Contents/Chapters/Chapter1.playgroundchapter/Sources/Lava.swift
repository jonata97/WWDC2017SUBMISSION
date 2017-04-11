import Foundation
import SpriteKit
import PlaygroundSupport


public class Lava: SKSpriteNode {
    
    var lavaGlow = [SKTexture]()
    
    required public init (coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    public init () {
        let color = UIColor()
        let texture = SKTexture(imageNamed:"lava.png")
        let size = texture.size()
        super.init(texture: texture, color: color, size: size)
        self.name = "lava"
        
        let body = SKPhysicsBody(rectangleOf: self.size)
        body.friction = 0.6
        body.collisionBitMask = PhysicsCategory.Player
        body.categoryBitMask = PhysicsCategory.Danger
        body.contactTestBitMask = PhysicsCategory.Player
        body.affectedByGravity = false
        body.isDynamic = false
        self.physicsBody = body
        self.color = UIColor(colorLiteralRed: 15, green: 33, blue: 44, alpha: 100)
        
        self.lavaAnimation()
        self.addParticle()
    }
    
    
    
    public func lavaAnimation() {
        
        
        let original: [vector_float2] = [
            vector_float2(0, 1),   vector_float2(0.5, 1),   vector_float2(1, 1),
            vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),
            vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0)
        ]
        
        let first: [vector_float2] = [
            vector_float2(0, 1),   vector_float2(0.5, 1.2),   vector_float2(1, 1),
            vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),
            vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0)
        ]
        
        let second: [vector_float2] = [
            vector_float2(0, 1),   vector_float2(0.5, 1),   vector_float2(1, 1),
            vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),
            vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0)
        ]
        
        
        
        
        let warpGeometryGridNoWarp = SKWarpGeometryGrid(columns: 2, rows: 2)
        self.warpGeometry = warpGeometryGridNoWarp
        let warpGeometryGrid = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: original, destinationPositions: first)
        let warpGeometryGrid2 = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: first, destinationPositions: second)
        
        let warpAction = SKAction.animate(withWarps:[warpGeometryGrid,
                                                     warpGeometryGrid2
            ],
                                          times: [1.0, 3.0])
        
        self.run(SKAction.repeatForever(warpAction!))
        
    }
    
    public func addParticle() {
        let emitter = SKEmitterNode(fileNamed: "Fire.sks")
        
        emitter?.position = self.position
        emitter?.position.y = self.position.y+15
        emitter?.name = "particle"
        emitter?.zPosition = -5
        
        // Send the particles to the scene.
        emitter?.targetNode = self;
        self.addChild(emitter!)
    }
    
    
}
