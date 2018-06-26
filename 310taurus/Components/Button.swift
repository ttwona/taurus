import SpriteKit

class Button: SKSpriteNode {
    var value = 0
    var pressed: Bool = false
    var imageName: String = ""
    let kPressed = "_pressed"
    let buttonDelta: CGFloat = 7
    let okDelta: CGFloat = 6
    var textureSize = CGSize()
    
    func press() {
        self.textureSize = self.size
        if pressed {
            self.unpress()
        } else {
            self.texture = SKTexture(imageNamed: self.imageName + kPressed)
            self.pressed = true
            self.size = self.textureSize
        }
    }
    
    func unpress() {
        if pressed {
            self.texture = SKTexture(imageNamed: self.imageName)
            self.pressed = false
            self.size = self.textureSize
        }
    }
    
    func setImageName(name: String) {
        self.imageName = name
    }
}
