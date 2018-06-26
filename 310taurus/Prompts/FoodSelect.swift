import SpriteKit

class FoodSelect: Prompt {
    private var message: SKLabelNode?
    private var confirm: SKSpriteNode?
    private var buttons = [Button]()
    var foodSelected = ""
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionPrompt
        self.isPopup = true
        self.setupPrompt()
        self.showAvailable()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let confirm = self.confirm else {
            return
        }
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if let node = self.atPoint(location) as? Button {
                if confirm.contains(location) {
                    if self.foodSelected != "" {
                        let quantity = UserDefaults.standard.integer(forKey: self.foodSelected)
                        UserDefaults.standard.set(quantity - 1, forKey: self.foodSelected)
                        self.removeFromParent()
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(200)) {
                        node.unpress()
                    }
                } else if let name = node.name, UserDefaults.standard.integer(forKey: name) > 0 {
                    for button in self.buttons {
                        button.unpress()
                    }
                    
                    node.press()
                    
                    self.foodSelected = name
                    UserDefaults.standard.set(kChances[name], forKey: "chance")
                }
            } else {
                self.removeFromParent()
            }
        }
    }
    
    func setupPrompt() {
        guard let prompt = SKScene(fileNamed: "FoodSelect")?.getRootNode() else {
            return
        }
        
        let overlay = SKSpriteNode()
        overlay.color = kOverlayColor
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        prompt.removeFromParent()
        self.addChild(prompt)
        
        if let confirm = prompt.childNode(withName: "ok_button") as? Button,
            let red = prompt.childNode(withName: "red_food") as? Button,
            let green = prompt.childNode(withName: "green_food") as? Button,
            let orange = prompt.childNode(withName: "orange_food") as? Button,
            let blue = prompt.childNode(withName: "blue_food") as? Button {
            
            red.setImageName(name: "red_square")
            green.setImageName(name: "green_square")
            orange.setImageName(name: "orange_square")
            blue.setImageName(name: "blue_square")
            confirm.setImageName(name: "select_button")
            
            self.confirm = confirm
            self.buttons.append(blue)
            self.buttons.append(orange)
            self.buttons.append(green)
            self.buttons.append(red)
        }
    }
    
    func showAvailable() {
        for button in self.buttons where UserDefaults.standard.integer(forKey: button.name!) <= 0 {
            button.color = .black
            button.colorBlendFactor = kDisableBlendFactor
        }
    }
}
