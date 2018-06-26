import SpriteKit
import GameplayKit

class Inventory: Prompt {
    private var buttons =  [Button]()
    private var ok: Button?
    var chosenFood: Button?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionPrompt
        self.isPopup = true
        self.setup()
        self.showAvailable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        
        let positionInScene = touch.location(in: self)
        if let node = self.atPoint(positionInScene) as? Button {
            
            
            if node.name == "ok_button" {
                node.press()
            } else if node.name != "ok_button", UserDefaults.standard.integer(forKey: "coins") >= node.value {
                if node.pressed {
                    node.press()
                    self.chosenFood = nil
                } else {
                    for button in self.buttons {
                        button.unpress()
                    }
                    node.press()
                    self.chosenFood = node
                }
            }
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let positionInScene = touch.location(in: self)
        if let node = self.atPoint(positionInScene) as? Button {
            if node.name == "ok_button" {
                if let item = self.chosenFood {
                    item.unpress()
                    let confirmPrompt = ConfirmPurchase()
                    confirmPrompt.setItem(item: item)
                    self.addChild(confirmPrompt)
                    
                }
                node.unpress()
            }
        }
    }
    
    func setup() {
        guard let prompt = SKScene(fileNamed: "Inventory")?.getRootNode() else {
            return
        }
        
        let overlay = SKSpriteNode()
        overlay.color = kOverlayColor
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        prompt.removeFromParent()
        self.addChild(prompt)
        
        
        if let red = prompt.childNode(withName: "red_food") as? Button,
            let green = prompt.childNode(withName: "green_food") as? Button,
            let orange = prompt.childNode(withName: "orange_food") as? Button,
            let blue = prompt.childNode(withName: "blue_food") as? Button,
            let ok = prompt.childNode(withName: "ok_button") as? Button {
            
            self.buttons.append(red)
            self.buttons.append(green)
            self.buttons.append(orange)
            self.buttons.append(blue)
            self.ok = ok
            
            red.setImageName(name: "red_food")
            green.setImageName(name: "green_food")
            orange.setImageName(name: "orange_food")
            blue.setImageName(name: "blue_food")
            ok.setImageName(name: "select_button")
            
            red.value = 500
            green.value = 300
            orange.value = 100
            blue.value = 10
        }
    }
    
    func showAvailable() {
        let coins = UserDefaults.standard.integer(forKey: "coins")
        for button in self.buttons where button.value > coins {
            button.color = .black
            button.colorBlendFactor = kDisableBlendFactor
        }
    }
}
