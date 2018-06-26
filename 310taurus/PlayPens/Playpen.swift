import SpriteKit

class Playpen: SKNode {
    var containers = [SKSpriteNode]()
    var bowl: Bowl?
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionBase
        
        self.name = "location"
        
        self.createButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let bowl = self.bowl else {
            return
        }
        
        let touch = touches.first
        if let location = touch?.location(in: self) {
            if bowl.contains(location) {
                if Bowl.canFill() {
                    bowl.color = .cyan
                    let fillBowl = FoodSelect()
                    self.addChild(fillBowl)
                } else {
                    self.showPrompt(message: "Sorry, no food available")
                }
            } else {
                for container in self.containers where container.contains(location) {
                    let randomInt = Int.random(10)
                    let chance = UserDefaults.standard.integer(forKey: "chance")
                    switch randomInt {
                    case 0...chance:
                        bowl.color = .orange
                        UserDefaults.standard.set(0, forKey: "chance")
                        self.getCat()
                    case chance...10:
                        self.showPrompt(message: "Sorry, no cat here")
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func getCat() {
        guard let scene = self.scene else {
            return
        }
        
        if var names = UserDefaults.standard.array(forKey: "cats") as? [String], !names.isEmpty {
            let randomCat = names.chooseOne
            if let index = names.index(of: randomCat) {
                names.remove(at: index)
                UserDefaults.standard.set(names, forKey: "cats")
                if var found = UserDefaults.standard.array(forKey: "found") as? [String] {
                    found.append(randomCat)
                    UserDefaults.standard.set(found, forKey: "found")
                } else {
                    UserDefaults.standard.set([randomCat], forKey: "found")
                }
                
                let itemFound = ItemFound(catName: randomCat)
                scene.addChild(itemFound)
            }
        } else {
            self.showPrompt(message: "YOU HAVE FOUND ALL THE CATS")
            
        }
        
    }
    
    func showPrompt(message: String) {
        guard let scene = self.scene else {
            return
        }
        
        let prompt = SingleMessagePrompt(message: message)
        scene.addChild(prompt)
    }
    
    func createButtons() { }
}
