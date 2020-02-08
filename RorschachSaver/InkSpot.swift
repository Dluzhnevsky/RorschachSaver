import Cocoa

class InkSpot {
    
    // MARK: - Internal Properties
    
    var wasCreated = false
    var shouldBeGone = false
    var isGone = false
    
    // MARK: - Private Properties
    
    private var frame: NSRect
    private let peakBrightness: CGFloat
    private var brightness: CGFloat
    
    // MARK: - Init
    
    init(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, peakBrightness: CGFloat) {
        self.frame = NSRect(x: x, y: y, width: width, height: height)
        self.peakBrightness = peakBrightness
        self.brightness = 0
    }
    
    // MARK: - Internal Methods
    
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
        
        let spotColot = NSColor(white: 0.0, alpha: brightness)
        spotColot.set()
        
        // Left Spot
        let leftInkSpotRect = frame
        NSBezierPath(ovalIn: leftInkSpotRect).fill()
        
        // Right Spot
        let rightInkSpotRect = NSRect(x: rect.width - leftInkSpotRect.origin.x - leftInkSpotRect.width,
                                      y: leftInkSpotRect.origin.y,
                                      width: leftInkSpotRect.width,
                                      height: leftInkSpotRect.height)
        NSBezierPath(ovalIn: rightInkSpotRect).fill()
    }
    
}
