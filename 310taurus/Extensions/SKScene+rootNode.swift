import SpriteKit

extension SKScene {
    
    func getRootNode() -> SKNode? {
        guard let rootNode = self.childNode(withName: "//root_node") else {
            return nil
        }
        rootNode.removeFromParent()
        return rootNode
    }
}
