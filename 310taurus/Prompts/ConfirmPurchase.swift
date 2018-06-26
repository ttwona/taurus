import SpriteKit

class ConfirmPurchase: Prompt {
    private var message: SKLabelNode?
    private var cancel: SKSpriteNode?
    private var confirm: SKSpriteNode?
    private var item: Button?
    private var lessButton: SKSpriteNode?
    private var moreButton: SKSpriteNode?
    private var quantity = 1
    private var quantityText: SKLabelNode?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionTopPrompt
        self.isPopup = true
        
        self.createButtons()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let cancel = self.cancel, let confirm = self.confirm, let quantityText = self.quantityText, let lessButton = self.lessButton, let moreButton = self.moreButton, let scene = self.scene, let item = self.item else {
            return
        }
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if cancel.contains(location) {
                self.removeFromParent()
                
            } else if confirm.contains(location) {
                self.buyFood()
//                if let nextScene = SKScene(fileNamed: "PlayPen") {
//                    nextScene.size = scene.size
//                    nextScene.scaleMode = .aspectFit
//                    let transition = SKTransition.fade(withDuration: 0.5)
//                    scene.view?.presentScene(nextScene, transition: transition)
//                }
                if let parent = self.parent as? Inventory {
                    parent.chosenFood = nil
                    parent.showAvailable()
                }
                self.removeFromParent()
            } else if lessButton.contains(location) {
                self.quantity -= 1
                self.quantity = self.quantity < 1 ? 1 : self.quantity
                quantityText.text = String(self.quantity)
            } else if moreButton.contains(location) {
                let quantityCanAfford = UserDefaults.standard.integer(forKey: "coins") / item.value
                if self.quantity + 1 > quantityCanAfford {
                    return
                }
                self.quantity += 1
                quantityText.text = String(self.quantity)
            }
        }
    }
    
    func setItem(item: Button) {
        self.item = item
    }
    
    func buyFood() {
        guard let item = self.item, let name = self.item?.name else {
            return
        }
        
        let value = UserDefaults.standard.integer(forKey: name)
        UserDefaults.standard.setValue(value + self.quantity, forKey: name)
        
        let coins = UserDefaults.standard.integer(forKey: "coins")
        let deduct = self.quantity * item.value
        UserDefaults.standard.setValue(coins - deduct, forKey: "coins")
    }
    
    func createButtons() {
        let overlay = SKSpriteNode()
        overlay.color = kOverlayColor
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        let prompt = SKSpriteNode()
        prompt.color = .white
        prompt.size = CGSize(width: 300, height: 300)
        prompt.position = CGPoint(x: 0, y: 0)
        prompt.zPosition = 1000
        
        let count = SKLabelNode()
        count.text = String(1)
        count.horizontalAlignmentMode = .center
        count.fontColor = kFontColor
        count.fontName = kFontName
        count.position = CGPoint(x: 0, y: 0)
        count.zPosition = 1001
        
        let lessButton = SKSpriteNode()
        lessButton.size = CGSize(width: 20, height: 20)
        lessButton.position = CGPoint(x: -40, y: 0)
        lessButton.zPosition = 1001
        lessButton.color = .black
        lessButton.name = "less_button"
        
        let moreButton = SKSpriteNode()
        moreButton.size = CGSize(width: 20, height: 20)
        moreButton.position = CGPoint(x: 40, y: 0)
        moreButton.zPosition = 1001
        moreButton.color = .black
        moreButton.name = "more_button"
        
        let message = SKLabelNode.createMultiLineLabel(text: "Please Confirm Quantity", lineLength: 22, alignment: .center)
        message.fontColor = .black
        message.position = CGPoint(x: 0, y: 150 - 60)
        message.zPosition = 1001
        
        let yPos: CGFloat = -150 + 50
        let width = prompt.size.width / 2 - 30
        
        let cancel = SKSpriteNode(imageNamed: "ok_button")
        cancel.name = "cancel"
        cancel.size = CGSize(width: width, height: 40)
        cancel.position = CGPoint(x: prompt.size.width / 4 * -1 + 5, y: yPos)
        cancel.zPosition = 1001
        
        
        let confirm = SKSpriteNode(imageNamed: "ok_button")
        confirm.name = "confirm"
        confirm.size = CGSize(width: width, height: 40)
        confirm.position = CGPoint(x: prompt.size.width / 4 - 5, y: yPos)
        confirm.zPosition = 1001
        
        self.quantityText = count
        self.lessButton = lessButton
        self.moreButton = moreButton
        self.cancel = cancel
        self.confirm = confirm
        self.message = message
        
        prompt.addChild(count)
        prompt.addChild(lessButton)
        prompt.addChild(moreButton)
        prompt.addChild(cancel)
        prompt.addChild(confirm)
        prompt.addChild(message)
        
        self.addChild(prompt)
    }
}
