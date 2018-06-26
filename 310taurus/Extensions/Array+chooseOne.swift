import SpriteKit

extension Array {
    var chooseOne: Element { return self[Int(arc4random_uniform(UInt32(count)))] }
}
