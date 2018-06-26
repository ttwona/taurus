import SpriteKit

class Menu: Prompt {
    private var playpens: Button?
    private var inventory: Button?
    private var profile: Button?
    private var home: Button?
    private var sound: Button?
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init() {
        super.init()
        self.isUserInteractionEnabled = true
        
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.zPosition = kPositionMenu
        
        self.createButtons()
        self.setupInventoryButton()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let playpens = self.playpens,
            let inventory = self.inventory,
            let profile = self.profile,
            let home = self.home,
            let sound = self.sound,
            let scene = self.scene else {
            return
        }
        
        let touch = touches.first
        
        if let location = touch?.location(in: self) {
            if playpens.contains(location) {
                self.removeFromParent()
                let inventory = Playpens()
                scene.addChild(inventory)
                self.removeFromParent()
            } else if inventory.contains(location) {
                let coins = UserDefaults.standard.integer(forKey: "coins")
                
                if coins != 0 {
                    self.removeFromParent()
                    let inventory = Inventory()
                    scene.addChild(inventory)
                    self.removeFromParent()
                }
            } else if profile.contains(location) {
                if let _ = scene as? Profile {
                    self.removeFromParent()
                } else {
                    let nextScene = Profile()
                    nextScene.size = scene.size
                    nextScene.scaleMode = .aspectFit
                    let transition = SKTransition.fade(withDuration: 0.5)
                    scene.view?.presentScene(nextScene, transition: transition)
                }
            } else if sound.contains(location) {
                if let isSoundPlaying = SKTAudio.sharedInstance().backgroundMusicPlayer?.isPlaying, isSoundPlaying {
                    SKTAudio.sharedInstance().pauseBackgroundMusic()
                    UserDefaults.standard.set(false, forKey: "sound_on")
                } else {
                    SKTAudio.sharedInstance().playBackgroundMusic(kSongs.chooseOne)
                    UserDefaults.standard.set(true, forKey: "sound_on")
                }
                
                if let node = self.atPoint(location) as? Button  {
                    node.press()
                }
            } else if home.contains(location) {
                if let _ = scene as? MainScene {
                    self.removeFromParent()
                } else {
                    if let nextScene = SKScene(fileNamed: "MainScene") {
                        nextScene.size = scene.size
                        nextScene.scaleMode = .aspectFit
                        let transition = SKTransition.fade(withDuration: 0.5)
                        scene.view?.presentScene(nextScene, transition: transition)
                    }
                }
            }
        }
    }
    
    func setupInventoryButton() {
        guard let inventory = self.inventory else {
            return
        }
        
        let coins = UserDefaults.standard.integer(forKey: "coins")
        
        if coins <= 0 {
            inventory.color = .black
            inventory.colorBlendFactor = kDisableBlendFactor
        }
    }
    
    func createButtons() {
        let menu = Button()
        menu.color = kMenuOverlayColor
        menu.size = CGSize(width: 375, height: 667)
        menu.position = CGPoint(x: 0.0, y: 0.0)
        self.addChild(menu)

        let sound = Button(imageNamed: "sound")
        let playpens = Button(imageNamed: "playpen")
        let inventory = Button(imageNamed: "inventory")
        let profile = Button(imageNamed: "profile")
        let home = Button(imageNamed: "home")
        
        playpens.name = "playpen"
        
        let size = CGSize(width: 60, height: 60)
        
        home.size = size
        playpens.size = size
        inventory.size = size
        profile.size = size
        sound.size = CGSize(width: 40, height: 40)
        
        home.position = CGPoint(x: -50, y: 50)
        playpens.position = CGPoint(x: 50, y: 50)
        inventory.position = CGPoint(x: -50, y: -50)
        profile.position = CGPoint(x: 50, y: -50)
        sound.position = CGPoint(x: 150, y: 290)
        
        let coins = UserDefaults.standard.integer(forKey: "coins")
        if coins == 0 {
            inventory.blendMode = .screen
        }
        
        sound.imageName = "sound"
        
        self.home = home
        self.playpens = playpens
        self.inventory = inventory
        self.profile = profile
        self.sound = sound
        
        menu.addChild(home)
        menu.addChild(playpens)
        menu.addChild(inventory)
        menu.addChild(profile)
        menu.addChild(sound)
    }
}
