import Cocoa

class InkGenerator {
    
    private enum state {
        case idling
        case painting
        case paused
    }
    
    var x: CGFloat
    var y: CGFloat
    var radius: CGFloat
    var brightness:CGFloat
    var rect: NSRect
    
    var border: CGFloat
    
    init(rect: NSRect) {
        self.radius = Randomizer.randomCGFloat * 50 + 20
        self.border = radius * 1.5
        self.x = Randomizer.randomCGFloat * (rect.width / 2.0 - border) + border
        self.y = Randomizer.randomCGFloat * (rect.height - border * 2) + border
        self.brightness = Randomizer.randomCGFloat / 2.0 + 0.5
        self.rect = rect
    }
    
    func makeNextInkSpot() -> InkSpot {
        let inkSpot = InkSpot(x: x, y: y, width: radius, height: radius)
        
        radius += Randomizer.randomCGFloat * 64.0 - 32.0
        
        if radius < 16.0 {
            radius = 16.0
        }
        
        if radius > 128.0 {
            radius = 128.0
        }
        
        x += Randomizer.randomCGFloat * 64.0 - 32.0
        
        if x < border {
            x = border
        }
        else if x > rect.width / 2.0 {
            x = rect.width / 2.0
        }
        
        y += Randomizer.randomCGFloat * 64.0 - 32.0
        
        if y < border {
            y = border
        }
        else if y > rect.height - border {
            y = rect.height - border
        }
        
        brightness += Randomizer.randomCGFloat * 0.2 - 0.1
        
        if brightness > 1.0 {
            brightness = 1.0
        }
        else if brightness < 0.5 {
            brightness = 0.5
        }
        
        return inkSpot
    }
    
}
