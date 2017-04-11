import PlaygroundSupport
import Foundation
import SpriteKit
import AVFoundation

//func to subtract vectors
func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}


public class Scene:SKScene, SKPhysicsContactDelegate {
    
    
    //background variables
    
    let moon = SKSpriteNode(imageNamed: "moon.png")
    let frontGrass = SKSpriteNode(imageNamed: "frontGrass.png")
    let frontGrass2 = SKSpriteNode(imageNamed: "frontGrass.png")
    let undergroundBackground = SKSpriteNode(imageNamed: "undergroundBackground.png")
    let undergroundBackground2 = SKSpriteNode(imageNamed: "undergroundBackground.png")
    let undergroundBackground3 = SKSpriteNode(imageNamed: "undergroundBackground.png")
    let closeMountains = SKSpriteNode(imageNamed: "closeMountains.png")
    let farMountains = SKSpriteNode(imageNamed: "farMountains.png")
    let bgGrass = SKSpriteNode(imageNamed: "bgGrass.png")
    var lastClosePosition = 0
    var lastFarPosition = 0
    var lastBgGrassPosition = 0
    var background = SKSpriteNode (imageNamed: "backgroundUpper.jpg")
    var spaceship = SKSpriteNode (imageNamed: "nave.png")
    var terraformIntroNode = SKSpriteNode()
   
    //music variables
    var musicLevel1 = true
    var musicLevel2 = true
    var musicLevel3 = true
    
    

    
    //playSound
    var audioPlayer = AVAudioPlayer()
    
    
    //player variables
    let player = Player();
    
    //moving variables
    var isTouching = false
    var touchLocation = CGPoint(x: 0, y: 0)
    
    //cam variables
    var cam = SKCameraNode()
    
    //hud variables
    var fuel = 3
    var fuelSprite = SKSpriteNode();
    var crystalCollected = 0
    var warningLabel = SKLabelNode()
    
    
    //wait variables
    var time = TimeInterval();
    var deltaTime = TimeInterval();
    var lastTime = TimeInterval();
    
    
    
    
    //init
    public override init(size: CGSize) {
        super.init(size: size)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override public func didMove(to view: SKView) {
        
        self.backgroundColor = UIColor.white
        self.scaleMode = .aspectFill
        self.physicsWorld.gravity.dy = -4
        self.physicsWorld.contactDelegate = self
        
        
        
        
        
        
        // creatingMap
        let map = Map()
        self.createMap(mapArray: map.getStarterLevel(), xValue: 0, yValue: 0)
        self.createMap(mapArray: map.getLevel(), xValue: 1024, yValue: 0)
        self.createMap(mapArray: map.getLevel2(), xValue: 2048, yValue: 0)
        self.createMap(mapArray: map.getUnderLevel(), xValue: 2048, yValue: -768)
        self.createMap(mapArray: map.getUnderLevel2(), xValue: 1024, yValue: -768)
        self.createMap(mapArray: map.getUnderLevel3(), xValue: 0, yValue: -768)
        self.createMap(mapArray: map.getUnderLevel4(), xValue: 0, yValue: -768*2)
        self.createMap(mapArray: map.getUnderLevel5(), xValue: 1024, yValue: -768*2)
        self.createMap(mapArray: map.getUnderLevel6(), xValue: 2048, yValue: -768*2)
        self.createMap(mapArray: map.getSkyLevel(), xValue: 1024, yValue: 768)
        self.createMap(mapArray: map.getSkyLevel2(), xValue: 2048, yValue: 768)
        
        
        //add background
        self.addBackground()
        
        //add player
        self.addPlayer()
        
        //add camera
        self.settingCamera()
        
        
        //add hud
        self.addHud()
        
        //add items
        self.addItems()
        
        
        
        
        
    }
    
    
    
    public func addItems () {
        let blueCrystal = Crystal(imageNamed:"blueCrystal.png")
        blueCrystal.position.x = 2500
        blueCrystal.position.y = 1180
        self.addChild(blueCrystal)
        
        let pinkCrystal = Crystal(imageNamed:"pinkCrystal.png")
        pinkCrystal.position.x = 600
        pinkCrystal.position.y = -355
        self.addChild(pinkCrystal)
        
        let yellowCrystal = Crystal(imageNamed:"yellowCrystal.png")
        yellowCrystal.position.x = 3025
        yellowCrystal.position.y = -1315
        self.addChild(yellowCrystal)
        
        let indicationRock = SKSpriteNode(imageNamed: "rock.png")
        indicationRock.position.x = 2550
        indicationRock.position.y = 110
        indicationRock.zPosition = -5
        self.addChild(indicationRock)
        
        
        
    }
    
    // adding background
    public func addBackground () {
        
        //  backgroundSettings
        background.size = self.size
        background.zPosition = -6000
        background.position.x = self.size.width/2
        background.position.y = self.size.height/2
        self.addChild(background)
        
        //undergroundBackgroundSettings
        undergroundBackground.position.x = 2560
        undergroundBackground.position.y = -384
        undergroundBackground.zPosition = -1000
        self.addChild(undergroundBackground)
        
        undergroundBackground2.position.x = 1536
        undergroundBackground2.position.y = -384
        undergroundBackground2.zPosition = -1000
        self.addChild(undergroundBackground2)
        
        undergroundBackground3.position.x = 512
        undergroundBackground3.position.y = -384
        undergroundBackground3.zPosition = -1000
        self.addChild(undergroundBackground3)
        
        //spaceship
        spaceship.position.x = 300
        spaceship.position.y = 150
        spaceship.size.width = 192
        spaceship.size.height = 192
        spaceship.zPosition = -10
        self.addChild(spaceship)
        
        //parallax background
        farMountains.position.x = 2030
        farMountains.position.y = 210
        farMountains.zPosition = -500
        self.addChild(farMountains)
        
        closeMountains.position.x = 2030
        closeMountains.position.y = 210
        closeMountains.zPosition = -100
        self.addChild(closeMountains)
        
        bgGrass.position.x = 2030
        bgGrass.position.y = 64
        bgGrass.zPosition = -50
        self.addChild(bgGrass)
        
        
        
        
        //moonSettings
        moon.size = CGSize(width: 150, height: 150)
        moon.zPosition = -5
        moon.position.x = 200
        moon.position.y = 550
        self.addChild(moon)
        
        
        //front grass
        frontGrass.size =  CGSize(width: 1024, height: 10)
        frontGrass.zPosition = 1
        frontGrass.position.x = 512
        frontGrass.position.y = 67
        self.addChild(frontGrass)
        frontGrass2.size =  CGSize(width: 1624, height: 10)
        frontGrass2.zPosition = 1
        frontGrass2.position.x = 1770
        frontGrass2.position.y = 67
        self.addChild(frontGrass2)
        
        //playSound
        self.playSound(name: "backgroundMusic")
        
    }

    func playSound(name:String) {
        
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: name, ofType: "mp3")!))
            audioPlayer.prepareToPlay()
            audioPlayer.numberOfLoops = -1
            audioPlayer.volume = 0.2
            audioPlayer.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    public func addHud () {
        
        //fuel
        fuelSprite = SKSpriteNode (imageNamed: "fullFuel.png")
        fuelSprite.position.x = self.size.width/2
        fuelSprite.position.y = self.size.height/2 + 200
        self.addChild(fuelSprite)
        
    
        
        //warningLabels
        warningLabel.position = CGPoint(x: 500, y: 400)
        warningLabel.fontSize = 30
        warningLabel.color = UIColor.red
        warningLabel.fontName = "Helvetica"
        warningLabel.isHidden = true
        self.addChild(warningLabel)
        
    }
    
    
    
    
    
    
    //adding player
    public func addPlayer() {
        player.position = CGPoint(x: 350 , y: 100)
        addChild(player)
    }
    
    //camera
    public func settingCamera () {
        
        cam.xScale = 1
        cam.yScale = 1
        cam.position.x = 512
        cam.position.y = 384
        
        self.camera = cam
        self.addChild(cam)
        
    }
    
    //handling collide
    
    public func teleportToStart() {
        //warping to make it feel like teleport
        let original: [vector_float2] = [
            vector_float2(0, 1),   vector_float2(0.5, 1),   vector_float2(1, 1),
            vector_float2(0, 0.5), vector_float2(0.5, 0.5), vector_float2(1, 0.5),
            vector_float2(0, 0),   vector_float2(0.5, 0),   vector_float2(1, 0)
        ]
        
        let first: [vector_float2] = [
            vector_float2(-1, 1.5), vector_float2(0.5, 1.75), vector_float2(2, 1.5),
            vector_float2(-2, 0.5),   vector_float2(0.5, 0.5),   vector_float2(2, 0.5),
            vector_float2(-1, -1.5),  vector_float2(0.5, -0.75),  vector_float2(1.5, -1.5)
        ]
        
        let second: [vector_float2] = [
            vector_float2(1, -1.5), vector_float2(0.5, -1.75), vector_float2(-2, -1.5),
            vector_float2(2, 0.5),   vector_float2(0.5, 0.5),   vector_float2(2, 0.5),
            vector_float2(1, 1.5),  vector_float2(0.5, 0.75),  vector_float2(-1.5, 1.5)
        ]
        
        
        let warpGeometryGridNoWarp = SKWarpGeometryGrid(columns: 2, rows: 2)
        player.warpGeometry = warpGeometryGridNoWarp
        let warpGeometryGrid = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: original, destinationPositions: first)
        let warpGeometryGrid2 = SKWarpGeometryGrid(columns: 2, rows: 2, sourcePositions: first, destinationPositions: second)
        
        let warpAction = SKAction.animate(withWarps:[warpGeometryGrid,
                                                     warpGeometryGrid2,
                                                     warpGeometryGridNoWarp
            ],
                                          times: [0.0, 1.5, 2.5 ])
        
        
        self.player.physicsBody?.isDynamic = false
        self.player.physicsBody?.affectedByGravity = false
        self.player.run(warpAction!)
        self.player.tpPlayer() {
            self.player.run(warpAction!)
            self.player.run(SKAction.move(to: CGPoint(x: 100, y:100), duration: 0))
            self.cam.run(SKAction.move(to: CGPoint(x: 512, y: 384), duration: 0))
            self.background.run(SKAction.move(to: CGPoint(x: 512, y: 384), duration: 0))
            self.farMountains.run(SKAction.move(to: CGPoint(x: 2030, y: 210), duration: 0))
            self.closeMountains.run(SKAction.move(to: CGPoint(x: 2030, y: 210), duration: 0))
            self.bgGrass.run(SKAction.move(to: CGPoint(x: 2030, y: 64), duration: 0))
            self.player.run(SKAction.scale(to: 0, duration: 0))
            self.player.run(SKAction.scale(to: 1, duration: 1))
            self.player.physicsBody?.isDynamic = true
            self.player.physicsBody?.affectedByGravity = true
            
        }
        
        if (crystalCollected == 3) {
            
            self.playSound(name: "winLevel")
            musicLevel3 = false
            musicLevel2 = false
            musicLevel1 = false
            let machine = Engine()
            machine.setScale(1)
            machine.position.y = 384
            machine.position.x = 512
            machine.zPosition = -10
            machine.setScale(3)
            
            let smokeEmitter = SKEmitterNode(fileNamed:  "Smoke.sks")
            smokeEmitter?.position.x = 100
            smokeEmitter?.position.y = 100
            smokeEmitter?.zPosition = 1000
            self.addChild(smokeEmitter!)
            smokeEmitter?.run(SKAction.sequence([SKAction.wait(forDuration: 3), SKAction.move(to: machine.position, duration: 3), SKAction.scale(to: 0, duration: 1)]))
            
            
            self.run(SKAction.sequence([SKAction.wait(forDuration: 6), SKAction.run {
                
                self.addChild(machine)
                
                }]))
            let endScene = SKSpriteNode(imageNamed: "endScene.jpg")
            endScene.position.x = 512
            endScene.position.y = 384
            endScene.alpha = 0
            endScene.zPosition = 1000
            self.addChild(endScene)
            endScene.run(SKAction.sequence([SKAction.wait(forDuration: 13), SKAction.fadeIn(withDuration: 2)]))
            self.run(SKAction.sequence([SKAction.wait(forDuration: 14), SKAction.stop()]))
            
            
            
        }
        
        
    }
    
    func playerDidCollideWithItem(player: SKSpriteNode, item: SKSpriteNode) {
        
        if (item.name == "crystal") {
            crystalCollected += 1
            let emitter = SKEmitterNode(fileNamed: "gotCrystal.sks")
            emitter?.particleBirthRate = 168
            emitter?.position = item.position
            emitter?.name = "emitterCrystal"
            emitter?.zPosition = 100
            emitter?.targetNode = self;
            self.addChild(emitter!)
            emitter?.run(SKAction.sequence([SKAction.wait(forDuration: 2), SKAction.run {
                
                emitter?.particleBirthRate = 0
                
                }]))
            
            item.removeFromParent()
            
            if (crystalCollected == 3) {
                self.teleportToStart()
                
            }
        }
    
        
        if (item.name == "lava" || item.name == "spikes") {
            self.teleportToStart()
        }
        
        
        
    }
    
    
    //    Handling physics
    public func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Item != 0)) {
            if let playerCollide = firstBody.node as? SKSpriteNode, let
                item = secondBody.node as? SKSpriteNode {
                playerDidCollideWithItem(player: playerCollide, item: item)
            }
        }
        
        if ((firstBody.categoryBitMask & PhysicsCategory.Player != 0) &&
            (secondBody.categoryBitMask & PhysicsCategory.Danger != 0)){
            if let playerCollide = firstBody.node as? SKSpriteNode, let
                item = secondBody.node as? SKSpriteNode {
                playerDidCollideWithItem(player: playerCollide, item: item)
                
            }
            
        }
    }
    
    
    
    //function to add tiles
    public func createMap (mapArray:[[String]], xValue: Int, yValue: Int) {
        
        var block = mapArray
        var blockType = SKSpriteNode();
        
        
        
        for i in 0...23 {
            
            for j in 0...31 {
                
                switch block[i][j] {
                    
                    //transparent
                    
                case "T":
                    blockType = Empty()
                case "B":
                    blockType = Ground(imageNamed: "darkBlueWithGrass.png")
                    blockType.size = CGSize (width: 32, height: 32)
                    
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder.jpeg")
                    }
                    
                    if (yValue == -768 * 2) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder2.jpg")
                        
                    }
                // grass inverted
                case "C":
                    blockType = Ground(imageNamed: "darkBlueWithGrass.png")
                    blockType.size = CGSize (width: 32, height: 32)
                    blockType.yScale = -1
                    
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder.jpeg")
                    }
                    
                    if (yValue == -768 * 2) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder2.jpg")
                        
                    }
                    
                // grass in this -> side of the block
                case "BR":
                    blockType = Ground(imageNamed: "darkBlueWithGrass.png")
                    blockType.size = CGSize (width: 32, height: 32)
                    blockType.zRotation = 90
                    
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder.jpeg")
                    }
                    
                    if (yValue == -768 * 2) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder2.jpg")
                        
                    }
                    
                // grass in this <- side of the block
                case "BL":
                    blockType = Ground(imageNamed: "darkBlueWithGrass.png")
                    blockType.size = CGSize (width: 32, height: 32)
                    blockType.zRotation = 90
                    blockType.xScale = -1
                    
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder.jpeg")
                    }
                    
                    if (yValue == -768 * 2) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueWithGrassUnder2.jpg")
                        
                    }
                    
                //ground without grass
                case "R":
                    blockType = Ground(imageNamed: "darkBlueNoGrass.jpg")
                    
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueNoGrassUnder.jpg")
                    }
                    
                    if (yValue == -768 * 2) {
                        blockType.texture = SKTexture(imageNamed: "darkBlueNoGrassUnder2.jpg")
                        
                    }
                    
                //small platform
                case "SP":
                    let pos = CGPoint (x: j*32+xValue+16, y: (23-i)*32+yValue+16)
                    blockType = SmallPlatform(position: pos)
                    
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "smallPlatformUnder.png")
                    }
                    
                //small platform
                case "BP":
                    blockType = BigPlatform()
                    if (yValue < 0) {
                        blockType.texture = SKTexture(imageNamed: "bigPlatformUnder.png")
                    }
                    
                    
                //block with edge grass ->
                case "EL":
                    blockType = Ground(imageNamed: "darkBlueEdgeWithGrass.png")
                    blockType.size.width = 40
                    if (yValue<0) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder.png")
                    }
                    
                    if (yValue == -768*2) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder2.png")
                        
                    }
                    
                //block with edge grass <-
                case "ER":
                    
                    blockType = Ground(imageNamed: "darkBlueEdgeWithGrass.png")
                    blockType.size.width = 40
                    blockType.xScale = -1
                    if (yValue<0) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder.png")
                    }
                    
                    if (yValue == -768*2) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder2.png")
                        
                    }
                    
                    
                    
                //block with edge y: inverted x: <-
                case "EBR":
                    blockType = Ground(imageNamed: "darkBlueEdgeWithGrass.png")
                    blockType.size.width = 40
                    blockType.yScale = -1
                    blockType.xScale = -1
                    if (yValue<0) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder.png")
                    }
                    
                    if (yValue == -768*2) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder2.png")
                        
                    }
                    
                    
                    
                //block with edge y: inverted x: ->
                case "EBL":
                    
                    blockType = Ground(imageNamed: "darkBlueEdgeWithGrass.png")
                    blockType.size.width = 40
                    blockType.yScale = -1
                    if (yValue<0) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder.png")
                    }
                    
                    if (yValue == -768*2) {
                        blockType.texture = SKTexture(imageNamed: "darBlueEdgeWithGrassUnder2.png")
                        
                    }
                    
                    
                    
                    
                case "S":
                    
                    blockType = Lava()
                    blockType.zPosition = -30
                    //                    if(j%2==0) {
                    //                        blockType.xScale = -1
                    //                    }
                    
                    if (yValue == -768*2) {
                        blockType = Spikes()
                    }
                    
                    
                    
                    
                    
                default:
                    print("")
                    
                }
                
                blockType.position = CGPoint (x: j*32+xValue+16, y: (23-i)*32+yValue+16)
                
                if(!(blockType is Empty)){self.addChild(blockType)}
            }
            
        }
        
        
        
    }
    
    
    
    
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        //setting variables to start the moves
        isTouching = true
        let touch = touches.first!
        touchLocation = touch.location(in: self)
        
        
        
        
        
    }
    
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isTouching = false
        
        
    }
    
    
    public override func update(_ currentTime: TimeInterval) {
        
        
        //player animation
        if (!isTouching) {
            if ((player.action(forKey: "playerIdle")) == nil) {
                if((player.action(forKey: "playerFly")) != nil) {
                    
                    //ver se ele só atualiza quando o velocity é zero pra da (ou implementar o toque com o chão)
                    if (player.physicsBody?.velocity.dx == 0) {
                        player.removeAction(forKey: "playerFly")
                        player.idlePlayer()
                    }
                } else {
                    player.idlePlayer()
                }
                
            }
        } else {
            if ((player.action(forKey: "playerFly")) == nil) {
                player.removeAction(forKey: "playerIdle")
                player.flyPlayer()
                fuelSprite.position.y = player.position.y + 65
            }
        }
        
        
        //fuel calculations
        deltaTime = currentTime - lastTime
        lastTime = currentTime
        time += deltaTime
        
        

        
        //warning
        warningLabel.position.x = cam.position.x
        warningLabel.position.y = cam.position.y+200

        
        
        
        switch fuel {
            
        case 1:
            fuelSprite.run(SKAction.setTexture(SKTexture(imageNamed: "oneFuel.png")))
        case 2:
            fuelSprite.run(SKAction.setTexture(SKTexture(imageNamed: "twoFuel.png")))
        case 3:
            fuelSprite.run(SKAction.setTexture(SKTexture(imageNamed: "fullFuel.png")))
        case 0:
            fuelSprite.run(SKAction.setTexture(SKTexture(imageNamed: "emptyFuel.png")))
        default:
            fuelSprite.run(SKAction.setTexture(SKTexture(imageNamed: "emptyFuel.png")))
        }
        
        
        //fuel sprite positioning
        fuelSprite.position.x = player.position.x + 10
        
        fuelSprite.setScale(0.2)
        fuelSprite.position.y = player.position.y + 60

        
        
        
        
        //prevents player from going off the screen
        if (player.position.x < 32) {
            
            player.physicsBody!.applyImpulse(CGVector(dx:150,dy:0))
        }
        
        if (player.position.x > 3072) {
            
            player.physicsBody!.applyImpulse(CGVector(dx:-150,dy:0))
        }
        
        //player moves and spends fuel
        if (isTouching && fuel>0) {
            
            if (time>1.4) {
                fuel -= 1
                time = 0
            }
            fuelSprite.position.y = player.position.y + 65
            
            if (touchLocation.x < player.position.x) {
                
                player.physicsBody!.applyImpulse(CGVector(dx:-8,dy:35))
                player.xScale = -1
                
                
                
            } else {
                player.physicsBody!.applyImpulse(CGVector(dx:8,dy:35))
                player.xScale = 1
                
                
            }
        } else if (fuel<3){
            if (isTouching) {
                if (touchLocation.x < player.position.x) {
                    player.physicsBody!.applyImpulse(CGVector(dx:-5,dy:0))
                    player.xScale = -1
                    
                    
                } else {
                    player.physicsBody!.applyImpulse(CGVector(dx:5,dy:0))
                    player.xScale = 1
                    
                    
                }}
            // recharges fuel faster if the player is not moving
            var waitTime = 0.0
            if(player.physicsBody?.velocity.dy==0 && player.physicsBody?.velocity.dx==0) {
                waitTime = 0.1
            } else {
                waitTime = 2.0
            }
            if(!isTouching && time>waitTime) {
                fuel += 1
                time = 0
            }
            
            
            
        }
        
        
        
        
        
        //background and cam mapping
        //x verifications
        if (player.position.x>(1024/2) && player.position.x < 2560) {
            cam.position.x = player.position.x
            background.position.x = player.position.x
            //parallax
            closeMountains.position.x -= (player.physicsBody?.velocity.dx)! * 0.002
            lastClosePosition = Int(closeMountains.position.x)
            
            farMountains.position.x -= (player.physicsBody?.velocity.dx)! * 0.001
            lastFarPosition = Int(farMountains.position.x)
            
            bgGrass.position.x -= (player.physicsBody?.velocity.dx)! * 0.003
            lastBgGrassPosition = Int(bgGrass.position.x)
            
            
            
        }
        
        if (player.position.x>2560) {
            
            cam.position.x = 2560
            background.position.x = 2560
            closeMountains.position.x = CGFloat(lastClosePosition)
            farMountains.position.x = CGFloat(lastFarPosition)
            
        }
        
        
        //y verifications
        if (player.position.y > 0) {
            if (musicLevel1) {
                self.playSound(name: "backgroundMusic")
                musicLevel1 = false
                musicLevel2 = true
                musicLevel3 = true
            }
        }
        
        
        if (player.position.y > 384) {
            
            
            self.cam.position.y = self.player.position.y
            self.background.position.y = self.player.position.y
            
            //musicLevel1
            
            
            
        } else if (player.position.y>0 && player.position.y < 700) {
            
            cam.position.y = 384
            background.position.y = 384
            
        } else if (player.position.y<0 && player.position.y < 700  && player.position.y > -768) {
            cam.position.y = -384
            undergroundBackground3.position.y = -384
            undergroundBackground2.position.y = -384
            undergroundBackground.position.y = -384
            
            //musicLevel2
            if (musicLevel2) {
                
                self.playSound(name: "lavaLevel")
                musicLevel2 = false
                musicLevel1 = true
                musicLevel3 = true
            }
            
            
        } else if (player.position.y < -768 && player.position.y >
            -800) {
            cam.position.y = -1152
            undergroundBackground3.position.y = -1152
            undergroundBackground2.position.y = -1152
            undergroundBackground.position.y = -1152
            
            undergroundBackground3.texture = SKTexture(imageNamed: "undergroundBackground2.jpg")
            undergroundBackground2.texture = SKTexture(imageNamed: "undergroundBackground2.jpg")
            undergroundBackground.texture = SKTexture(imageNamed: "undergroundBackground2.jpg")
            
            //music level 3
            if (musicLevel3) {
               
                self.playSound(name: "yellowLevel")
                musicLevel3 = false
                musicLevel1 = true
                musicLevel2 = true
            }
     
        }
        
        
        
        
        
        //max player velocity
        if(player.physicsBody!.velocity.dx > 250) {
            player.physicsBody!.velocity.dx = 250
            
        } else if (player.physicsBody!.velocity.dx < -250) {
            player.physicsBody!.velocity.dx = -250
        }
        
        
        
        if(!(player.physicsBody?.velocity.dy.isLess(than: 250))!) {
            player.physicsBody?.velocity.dy = 250
        }
        
        
        
        
        
        
        
    }
    
    public func addIntro () {
   
            var terraformIntro = [SKTexture]()
                        for i in 0...10 {
                let terraformIntroTexture = "terraformIntro\(i).png"
                terraformIntro.append(SKTexture(imageNamed: terraformIntroTexture))
            }
        
            
            terraformIntroNode.run(SKAction.repeatForever(
                SKAction.animate(with: terraformIntro,
                                 timePerFrame: 0.1,
                                 resize: false,
                                 restore: true)),
                     withKey:"terraformIntro")
        
            terraformIntroNode.position.x = 512
            terraformIntroNode.position.y = 384
            terraformIntroNode.size = self.size
            terraformIntroNode.zPosition = 1000
            self.addChild(terraformIntroNode)
            player.physicsBody?.isDynamic = false
    
    
    }
    
    
    public func removeIntro () {
        self.terraformIntroNode.run(SKAction.fadeOut(withDuration: 2))
        self.terraformIntroNode.removeFromParent()
        player.physicsBody?.isDynamic = true
        
    
        
    }
    
    
    
}












