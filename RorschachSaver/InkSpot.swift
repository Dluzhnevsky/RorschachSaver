import Cocoa

class InkSpot {
    
    let peakBrightness: CGFloat = Randomizer.randomCGFloat / 2.0 + 0.5
    
    var brightness: CGFloat = 0.0
    var wasCreated = false
    var shouldBeGone = false
    var isGone = false
    
    var frame: NSRect
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        self.frame = NSRect(x: x, y: y, width: width, height: height)
    }
    
    func update(_ rect: NSRect) {
        if !wasCreated {
            brightness += 0.03
        }
        else if shouldBeGone {
                brightness -= 0.02
        }
        
        if brightness >= peakBrightness {
            wasCreated = true
        }
        
        if brightness <= 0 && wasCreated {
            isGone = true
        }
        
        // L
        NSColor.init(white: 0.0, alpha: brightness).set()
        let leftInkSpotRect = self.frame
        NSBezierPath.init(ovalIn: leftInkSpotRect).fill()
        
        // R
        let rightInkSpotRect = NSRect.init(x: rect.width - self.frame.origin.x - self.frame.width,
                                          y: self.frame.origin.y,
                                          width: self.frame.width,
                                          height: self.frame.height)
        NSBezierPath.init(ovalIn: rightInkSpotRect).fill()
    }
    
}
