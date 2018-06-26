import SpriteKit
import GameplayKit

class Playpens: Prompt {
    private var buttons =  [Button]()
    private var ok: Button?
    private var chosenFood: Button?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionPrompt
        self.isPopup = true
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        
        let positionInScene = touch.location(in: self)
        if let node = self.atPoint(positionInScene) as? Button, let scene = self.scene as? MainScene {
            
            
            if node.name == "ok_button" {
                self.removeFromParent()
            } else {
                for button in self.buttons {
                    button.unpress()
                }
                
                node.press()
                UserDefaults.standard.set(node.name!, forKey: "location")
                scene.updateLocation()
            }
        }
    }
    
    func setup() {
        guard let prompt = SKScene(fileNamed: "Playpens")?.getRootNode() else {
            return
        }
        
        let overlay = SKSpriteNode()
        overlay.color = kOverlayColor
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        prompt.removeFromParent()
        self.addChild(prompt)
        
        
        if let locationOne = prompt.childNode(withName: "location_one") as? Button,
            let locationTwo = prompt.childNode(withName: "location_two") as? Button,
            let locationThree = prompt.childNode(withName: "location_three") as? Button,
            let locationFour = prompt.childNode(withName: "location_four") as? Button,
            let ok = prompt.childNode(withName: "ok_button") as? Button {
            
            self.buttons.append(locationOne)
            self.buttons.append(locationTwo)
            self.buttons.append(locationThree)
            self.buttons.append(locationFour)
            self.ok = ok
            
            locationOne.setImageName(name: "location")
            locationTwo.setImageName(name: "location")
            locationThree.setImageName(name: "location")
            locationFour.setImageName(name: "location")
            ok.setImageName(name: "select_button")
        }
    }
}
