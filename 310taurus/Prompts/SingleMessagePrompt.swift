import SpriteKit

class SingleMessagePrompt: Prompt {
    private var messageLabel: SKLabelNode?
    private var confirm: SKSpriteNode?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(message: String) {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionTopPrompt
        self.isPopup = true
        
        self.setup(message: message)
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
    
    func setup(message: String) {
        let overlay = SKSpriteNode()
        overlay.color = kOverlayColor
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        let prompt = SKSpriteNode()
        prompt.color = .white
        prompt.size = CGSize(width: 300, height: 300)
        prompt.position = CGPoint(x: 0, y: 0)
        prompt.zPosition = kPositionTopPrompt + 1
        

        let name = SKLabelNode.createMultiLineLabel(text: message, lineLength: 17, alignment: .center)
        name.position = CGPoint(x: 0, y: prompt.size.height / 2 - 50)
        name.zPosition = kPositionTopPrompt +  2
        name.fontColor = .black
        name.horizontalAlignmentMode = .center
        
        let sadFace = SKSpriteNode()
        sadFace.size = CGSize(width: 120, height: 120)
        sadFace.color = .black
        sadFace.position = CGPoint(x: 0, y: 0)
        sadFace.zPosition = kPositionTopPrompt
        
        let confirmY: CGFloat = -1 * prompt.size.height / 2 + 50
        
        let confirm = SKSpriteNode(imageNamed: "ok_button")
        confirm.name = "confirm"
        confirm.size = CGSize(width: 200, height: 60)
        confirm.position = CGPoint(x: 0, y: confirmY)
        confirm.zPosition = kPositionTopPrompt +  2
        
        self.confirm = confirm
        
        prompt.addChild(name)
        prompt.addChild(confirm)
        prompt.addChild(sadFace)
        
        self.addChild(prompt)
    }
}
