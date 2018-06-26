import SpriteKit
import GameplayKit

class Profile: SKScene {
    var startY: CGFloat = 0.0
    var lastY: CGFloat = 0.0
    var moveableArea = SKSpriteNode()
    var menu: Menu?
    var bottomLimit: CGFloat = 0
    var coins: SKLabelNode?
    
    override func didMove(to view: SKView) {
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        moveableArea.position = CGPoint(x: 0, y: 0)
        self.addChild(moveableArea)
        
        self.addCatProfilse()
        
//        let bar = SKSpriteNode()
//        bar.color = kPinkColor
//        bar.size = CGSize(width: 375, height: 80)
//        bar.zPosition = 14999
//        bar.position = CGPoint(x: self.frame.midX, y: self.frame.minY + 40)
//        self.addChild(bar)
        
        self.setup()
    }
    
    func playBackgroundMusic() {
        guard let isAudioPlaying = SKTAudio.sharedInstance().backgroundMusicPlayer?.isPlaying else {
            return
        }
        
        if !isAudioPlaying, UserDefaults.standard.bool(forKey: "sound_on") {
            SKTAudio.sharedInstance().playBackgroundMusic(kSongs.chooseOne)
        }
    }
    
    func addCatProfilse() {
        guard let names = UserDefaults.standard.array(forKey: "found") as? [String] else {
            let sadCat = SKSpriteNode()
            sadCat.color = .white
            sadCat.size = CGSize(width: 100, height: 100)
            sadCat.position = CGPoint(x: 0, y: 0)
            self.addChild(sadCat)
            return
        }
        
        var yPosition = self.frame.maxY - 240
        let nextY: CGFloat = 310
        
        for index in 0..<names.count {
            let profile = CatProfile(catName: names[index])
            let xPosition = index % 2 == 0 ? self.frame.midX - 90 : self.frame.midX + 90
            profile.position = CGPoint(x: xPosition, y: yPosition)
            
            self.bottomLimit = -yPosition
            
            if index % 2 != 0 {
                yPosition -= nextY
            }
            
            self.moveableArea.addChild(profile)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // store the starting position of the touch
        let touch = touches.first
        let location = touch?.location(in: self)
        
        if let _ = self.atPoint(location!) as? Button {
            if let menu = self.menu, self.children.contains(menu) {
                menu.removeFromParent()
            } else {
                for case let child as Prompt in self.children where child.isPopup {
                    child.removeFromParent()
                }
                let menu = Menu()
                self.menu = menu
                self.addChild(menu)
            }
        } else {
            startY = location!.y
            lastY = location!.y
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self)
        // set the new location of touch
        let currentY = location!.y
        
        // Set Top and Bottom scroll distances, measured in screenlengths
        let topLimit: CGFloat = 0.0
        
        // Set scrolling speed - Higher number is faster speed
        let scrollSpeed: CGFloat = 1
        
        // calculate distance moved since last touch registered and add it to current position
        let newY = moveableArea.position.y + ((currentY - lastY) * scrollSpeed)
        
        // perform checks to see if new position will be over the limits, otherwise set as new position
        if newY < self.size.height * (-topLimit) {
            moveableArea.position = CGPoint(x: moveableArea.position.x, y: self.size.height * (-topLimit))
        } else if newY > self.bottomLimit {
            moveableArea.position = CGPoint(x: moveableArea.position.x, y: bottomLimit)
        } else {
            moveableArea.position = CGPoint(x: moveableArea.position.x, y: newY)
        }
        
        // Set new last location for next time
        lastY = currentY
    }
    
    func setup() {
        guard let topMenu = SKScene(fileNamed: "MainScene")?.getRootNode(),
            let coins = topMenu.childNode(withName: "//coins") as? SKLabelNode else {
            return
        }
        
        topMenu.removeFromParent()
        self.addChild(topMenu)
        
        self.coins = coins
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let coins = self.coins else {
            return
        }
        
        coins.update()
        self.playBackgroundMusic()
    }
}
