import SpriteKit

class ItemFound: Prompt {
    private var message: SKLabelNode?
    private var confirm: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(catName: String) {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionTopPrompt
        self.isPopup = true
        
        self.catFound(catName: catName)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let confirm = self.confirm else {
            return
        }
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if confirm.contains(location) {
                self.removeFromParent()
            }
        }
    }
    
    func catFound(catName: String) {
        let overlay = SKSpriteNode()
        overlay.color = kOverlayColor
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        let prompt = SKSpriteNode()
        prompt.color = .white
        prompt.size = CGSize(width: 300, height: 500)
        prompt.position = CGPoint(x: 0, y: 0)
        prompt.zPosition = kPositionTopPrompt + 1
        
        let cat = SKSpriteNode()
        cat.color = .black
        cat.anchorPoint = CGPoint(x: 0.5, y: 1)
        cat.size = CGSize(width: 200, height: 250)
        cat.position = CGPoint(x: 0, y: prompt.size.height / 2 - 50)
        cat.zPosition = kPositionTopPrompt +  2
        
        let nameY = cat.position.y - cat.size.height - 20
        
        let newString = catName.replacingOccurrences(of: "_", with: " ")
        
        let name = SKLabelNode.createMultiLineLabel(text: newString.capitalized, lineLength: 22, alignment: .center)
        name.position = CGPoint(x: 0, y: nameY)
        name.zPosition = kPositionTopPrompt +  2
        name.fontColor = .black
        name.horizontalAlignmentMode = .center
        
        let confirmY: CGFloat = -1 * prompt.size.height / 2 + 50
        
        let confirm = SKSpriteNode(imageNamed: "ok_button")
        confirm.name = "confirm"
        confirm.size = CGSize(width: 200, height: 60)
        confirm.position = CGPoint(x: 0, y: confirmY)
        confirm.zPosition = kPositionTopPrompt +  2
        
        self.confirm = confirm
        
        prompt.addChild(cat)
        prompt.addChild(name)
        prompt.addChild(confirm)
        
        self.addChild(prompt)
    }
}
