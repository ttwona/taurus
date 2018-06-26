import SpriteKit

class Bowl: SKSpriteNode {
    public static func canFill() -> Bool {
        for food in kFoods where UserDefaults.standard.integer(forKey: food) > 0 {
            return true
        }
         return false
    }
}
