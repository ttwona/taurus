import AVFoundation
import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var player: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserDefaults.standard.bool(forKey: "launched") {
            self.setup()
        }
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "MainScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
//            view.showsFPS = true
//            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setup() {
        let today = Date()
        UserDefaults.standard.set(today, forKey: "date")
        UserDefaults.standard.setValue(true, forKey: "launched")
        UserDefaults.standard.setValue(1000, forKey: "coins")
        UserDefaults.standard.setValue(0, forKey: "red_food")
        UserDefaults.standard.setValue(0, forKey: "green_food")
        UserDefaults.standard.setValue(0, forKey: "orange_food")
        UserDefaults.standard.setValue(0, forKey: "blue_food")
        UserDefaults.standard.set("location_one", forKey: "location")
        UserDefaults.standard.set(true, forKey: "sound_on")
        
        let names = ["cat_1", "cat_2", "cat_3", "cat_4", "cat_5", "cat_6", "cat_7", "cat_8", "cat_9", "cat_10"]
        UserDefaults.standard.set(names, forKey: "cats")
    }
}
