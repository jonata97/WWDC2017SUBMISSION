import UIKit
import Foundation
import SpriteKit
import PlaygroundSupport

public class GameViewController: UIViewController{
    
    
    public var myScene = Scene(size: CGSize (width: 1024, height: 768))
    public var startScene = Scene(size: CGSize (width: 1024, height: 768))
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        let view = self.view as! SKView
        self.myScene.addIntro()
        view.presentScene(myScene)
        

        
    }
    
    public override func loadView(){
        
        self.view = SKView(frame: CGRect(x: 0, y:0, width : 1024, height:768))

    }
    
}

extension GameViewController : PlaygroundLiveViewMessageHandler {
    
    public func liveViewMessageConnectionOpened() {
        
    }
    
    public func liveViewMessageConnectionClosed() {
        
    }
    
    public func receive(_ message: PlaygroundValue) {
        
        switch message {
        case let .string(method):
            if method == "go" {

                self.myScene.removeIntro()
            }
        default: break
        
        
        
        }
    }
}
