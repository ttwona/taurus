import UIKit
import SpriteKit

let kFontSize: CGFloat = 32
let kFontName = "Franklin Gothic Medium"
let kFontColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)

let kOverlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
let kMenuOverlayColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.9)
let kGreyColor = UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
let kPinkColor = UIColor(red: 237/255, green: 170/255, blue: 198/255, alpha: 1)

let kChances = ["blue_food": 3, "orange_food": 5, "green_food": 7, "red_food": 9]
let kFoodPositions = [CGPoint(x: -60, y: 100), CGPoint(x: 60, y: 10), CGPoint(x: -60, y: -27.3), CGPoint(x: 60, y: -27.3)]

let kFoods = ["blue_food", "orange_food", "green_food", "red_food"]

let kDisableBlendFactor: CGFloat = 0.6

let kPositionBase: CGFloat = 0
let kPositionPrompt: CGFloat = 1000
let kPositionMenu: CGFloat = 10000
let kPositionTopPrompt: CGFloat = 100000

let kSongs = ["butterfly.mp3", "dna.mp3", "run.mp3", "rain.mp3", "springday.mp3"]
