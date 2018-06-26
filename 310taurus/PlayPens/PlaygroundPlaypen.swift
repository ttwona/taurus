import SpriteKit

class PlaygroundPlaypen: Playpen {
    
    override func createButtons() {
        let overlay = SKSpriteNode()
        overlay.color = UIColor(red: 79/255, green: 79/255, blue: 79/255, alpha: 0.9)
        overlay.size = CGSize(width: 375, height: 667)
        overlay.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(overlay)
        
        let bowl = Bowl()
        bowl.size = CGSize(width: 50, height: 50)
        bowl.color = .red
        bowl.position = CGPoint(x: 0, y: 0)
        bowl.zPosition = 1000
        
        let box = SKSpriteNode()
        box.size = CGSize(width: 100, height: 100)
        box.position = CGPoint(x: 0, y: 100)
        box.zPosition = 1001
        box.color = .red
        
        let bush = SKSpriteNode()
        bush.size = CGSize(width: 20, height: 20)
        bush.position = CGPoint(x: 0, y: -100)
        bush.zPosition = 1001
        bush.color = .red
        
        super.containers.append(box)
        super.containers.append(bush)
        super.bowl = bowl
        
        overlay.addChild(bowl)
        overlay.addChild(box)
        overlay.addChild(bush)
    }
}
