import SpriteKit

extension SKLabelNode {
    func update() {
        self.text = String(UserDefaults.standard.integer(forKey: "coins"))
    }
    func multilined() -> SKLabelNode {
        let substrings: [String] = self.text!.components(separatedBy: "\n")
        return substrings.enumerated().reduce(SKLabelNode()) {
            let label = SKLabelNode(fontNamed: self.fontName)
            label.text = $1.element
            label.fontColor = self.fontColor
            label.fontSize = self.fontSize
            label.position = self.position
            label.horizontalAlignmentMode = self.horizontalAlignmentMode
            label.verticalAlignmentMode = self.verticalAlignmentMode
            let y = CGFloat($1.offset - substrings.count / 2) * self.fontSize
            label.position = CGPoint(x: 0, y: -y)
            $0.addChild(label)
            return $0
        }
    }
    
    public static func createMultiLineLabel(text: String, lineLength: Int, alignment: SKLabelHorizontalAlignmentMode) -> SKLabelNode {
        let singleLineMessage = SKLabelNode()
        singleLineMessage.fontSize = kFontSize
        singleLineMessage.fontName = kFontName
        singleLineMessage.fontColor = kFontColor
        singleLineMessage.verticalAlignmentMode = .top
        singleLineMessage.horizontalAlignmentMode = alignment
        singleLineMessage.text = SKLabelNode.addNewline(text: text, lineLength: lineLength)
        return singleLineMessage.multilined()
    }
    
    public static func addNewline(text: String, lineLength: Int) -> String {
        // Turn string into an array of words, add spaces inbetween
        var wordArray = Array(text.components(separatedBy: " ").map { [ $0 ] }.joined(separator: [" "]))
        var length = 0
        
        for index in 0..<wordArray.count - 1 where wordArray[index] != "\n" {
            length += wordArray[index].count
            if length + wordArray[index + 1].count > lineLength {
                // If the current item is a space character, replace.
                // If not, replace the next item
                let replaceIdx = wordArray[index] == " " ? index : index + 1
                wordArray[replaceIdx] = "\n"
                length = 0
            }
        }
        
        return wordArray.joined()
    }
}
