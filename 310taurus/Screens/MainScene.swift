import SpriteKit
import GameplayKit

class MainScene: SKScene {
    private var menu: SKNode?
    private var playpen: SKNode?
    var coins: SKLabelNode?
    
    override func didMove(to view: SKView) {
        guard let menu = self.childNode(withName: "//menu") as? SKSpriteNode,
            let coins = self.childNode(withName: "//coins") as? SKLabelNode else {
            return
        }
        
        self.menu = menu
        self.coins = coins
        coins.update()
        self.name = "playpen"
        self.initPlaypen()
        self.playBackgroundMusic()
        self.checkDaily()
    }
    
    func playBackgroundMusic() {
        guard let isAudioPlaying = SKTAudio.sharedInstance().backgroundMusicPlayer?.isPlaying else {
            return
        }
        
        if !isAudioPlaying, UserDefaults.standard.bool(forKey: "sound_on") {
            SKTAudio.sharedInstance().playBackgroundMusic(kSongs.chooseOne)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, let menu = self.menu else {
            return
        }
        
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        if node.name == "menu" {
            if self.children.contains(menu) {
                menu.removeFromParent()
            } else {
                for case let child as Prompt in self.children where child.isPopup {
                    child.removeFromParent()
                }
                let menu = Menu()
                self.menu = menu
                self.addChild(menu)
            }
        } else if node.name == "coins" {
            for case let child as Prompt in self.children where child.isPopup {
                child.removeFromParent()
            }
            // Add money hack
            UserDefaults.standard.setValue(1000, forKey: "coins")
            UserDefaults.standard.setValue(0, forKey: "red_food")
            UserDefaults.standard.setValue(0, forKey: "green_food")
            UserDefaults.standard.setValue(0, forKey: "orange_food")
            UserDefaults.standard.setValue(0, forKey: "blue_food")
            UserDefaults.standard.set("location_one", forKey: "location")
            let today = Date().addingTimeInterval(-24*60*60)
            UserDefaults.standard.set(today, forKey: "date")
            let names = ["cat_1", "cat_2", "cat_3", "cat_4", "cat_5", "cat_6", "cat_7", "cat_8", "cat_9", "cat_10"]
            UserDefaults.standard.set(names, forKey: "cats")
        }
    }
    
    func initPlaypen() {
        switch UserDefaults.standard.string(forKey: "location") {
        case "location_one":
            let playpen = PlaygroundPlaypen()
            self.playpen = playpen
            playpen.zPosition = -1000
            self.addChild(playpen)
        case "location_two":
            let playpen = ConcertHallPlaypen()
            self.playpen = playpen
            playpen.zPosition = -1000
            self.addChild(playpen)
        case "location_three":
            let playpen = OfficePlaypen()
            self.playpen = playpen
            playpen.zPosition = -1000
            self.addChild(playpen)
        case "location_four":
            let playpen = BeachPlaypen()
            self.playpen = playpen
            playpen.zPosition = -1000
            self.addChild(playpen)
        default:
            return
        }
    }
    
    func updateLocation() {
        guard let playpen = self.playpen else {
            return
        }
        
        playpen.removeFromParent()
        self.initPlaypen()
    }
    
    func checkDaily() {
        let today = Date()
        
        if let lastCheckedDate = UserDefaults.standard.object(forKey: "date") as? Date, Calendar.current.compare(lastCheckedDate, to: today, toGranularity: Calendar.Component.day) == .orderedAscending {
            UserDefaults.standard.set(today, forKey: "date")
            
            let coinCount = [10, 50, 100].chooseOne
            let daily = SingleMessagePrompt(message: "\(coinCount) coins collected")
            self.addChild(daily)
            
            let coins = UserDefaults.standard.integer(forKey: "coins")
            UserDefaults.standard.set(coins + coinCount, forKey: "coins")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        guard let coins = self.coins else {
            return
        }
        
        coins.update()
        self.playBackgroundMusic()
    }
}
