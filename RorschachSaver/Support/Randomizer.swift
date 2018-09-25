import Foundation

class Randomizer {
    
    static var randomCGFloat: CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    static func randomRange(min:CGFloat, max: CGFloat) -> NSInteger {
        return NSInteger((Randomizer.randomCGFloat * (max - min) + min).nextDown)
    }
    
}
