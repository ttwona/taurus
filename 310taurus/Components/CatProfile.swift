import SpriteKit

class CatProfile: SKSpriteNode {
    
    convenience init(catName: String) {
        self.init(color: .white, size: CGSize(width: 170, height: 300))
        self.color = .white
        
        let image = SKSpriteNode()
        image.size = CGSize(width: 160, height: 200)
        image.position = CGPoint(x: 0, y: 45)
        image.color = .black
        
        let name = SKLabelNode()
        let newString = catName.replacingOccurrences(of: "_", with: " ")
        name.text = newString.capitalized
        name.fontColor = .black
        name.position = CGPoint(x: 0, y: -90)
        
        let pink = SKSpriteNode()
        pink.size = CGSize(width: 170, height: 10)
        pink.position = CGPoint(x: 0, y: self.size.height / -2 + 5)
        pink.color = kPinkColor
        
        self.addChild(image)
        self.addChild(name)
        self.addChild(pink)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(texture: SKTexture!, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
}
