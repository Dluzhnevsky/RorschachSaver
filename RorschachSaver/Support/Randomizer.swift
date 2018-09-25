import Foundation

class Randomizer {
    
    static var randomCGFloat: CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    static func randomInAbsoluteRange(min:CGFloat, max: CGFloat) -> CGFloat {
        let randomInRange = Randomizer.randomCGFloat * (max - min) + min
        
        if Randomizer.randomCGFloat >= 0.5 {
            return randomInRange
        }
        else {
            return randomInRange * -1.0
        }
    }
    
}
