import Cocoa

class InkGenerator {
    
    // MARK: - Private Static Properties
    
    private static let idlingTime = 50
    private static let showingTime = 150
    private static let defaultInkAmount = 250
    
    // MARK: - Private Types
    
    private enum State {
        case idling
        case painting
        case showing
    }
    
    // MARK: - Private Properties
    
    private var x: CGFloat = 0
    private var y: CGFloat = 0
    private var radius: CGFloat = 0
    private var brightness:CGFloat = 0
    private var rect: NSRect
    
    private var state: State
    private var timerTick: NSInteger
    
    private var inkSpots: [InkSpot]
    
    // MARK: - Lifecycle
    
    init(rect: NSRect) {
        self.rect = rect
        
        self.state = .idling
        self.timerTick = 0
        
        inkSpots = [InkSpot]()
    }
    
    // MARK: - Internal Methods
    
    func drawUpdatedFrame(in rect: NSRect) {
        updateGenearatorState()
        
        NSColor.white.set()
        rect.fill()
        
        for (index, inkSpot) in inkSpots.enumerated().reversed() {
            inkSpot.update(rect)
            
            if inkSpot.isGone {
                inkSpots.remove(at: index)
            }
        }
        
        ("TEST" as NSString).draw(in: rect, withAttributes: nil)
    }
    
    // MARK: - Private Methods
    
    private func startPainting() {
        setup()
        proceedAppendingInkSpots(with: InkGenerator.defaultInkAmount)
    }
    
    private func setup() {
        self.radius = randomCGFloat * 50 + 20
        self.x = randomCGFloat * rect.width / 2.0
        self.y = randomCGFloat * rect.height
        self.brightness = randomCGFloat / 2.0 + 0.5
    }
    
    private func eraseAll() {
        for inkSpot in inkSpots {
            inkSpot.shouldBeGone = true
        }
    }
    
    private func updateGenearatorState() {
        switch state {
        case .idling:
            self.timerTick += 1
            if timerTick >= InkGenerator.idlingTime {
                startPainting()
                timerTick = 0
                state = .painting
            }
            
        case .painting:
            for inkSpot in inkSpots {
                guard inkSpot.wasCreated else {
                    return
                }
            }
            
            state = .showing
            
        case .showing:
            self.timerTick += 1
            if timerTick >= InkGenerator.showingTime {
                eraseAll()
                timerTick = 0
                state = .idling
            }
        }
    }
    
    private func proceedAppendingInkSpots(with currentInkAmount: NSInteger) {
        let spotPrakBrightness = randomCGFloat / 2.0 + 0.5
        let inkSpot = InkSpot(x: x, y: y, width: radius, height: radius, peakBrightness: spotPrakBrightness)
        
        radius += randomCGFloat * 64.0 - 32.0
        
        if radius < 32.0 {
            radius = 32.0
        }
        
        if radius > 192.0 {
            radius = 192.0
        }
        
        x += randomInAbsoluteRange(min: 16.0, max: 32.0)
        
        if x < 0 {
            x = 0
        }
        else if x > rect.width / 2.0 {
            x = rect.width / 2.0
        }
        
        y += randomInAbsoluteRange(min: 16.0, max: 32.0)
        
        if y < 0 {
            y = 0
        }
        else if y > rect.height - radius {
            y = rect.height - radius
        }
        
        brightness += randomCGFloat * 0.2 - 0.1
        
        if brightness > 1.0 {
            brightness = 1.0
        }
        else if brightness < 0.5 {
            brightness = 0.5
        }
        
        inkSpots.append(inkSpot)
        
        if currentInkAmount > 0 {
            proceedAppendingInkSpots(with: currentInkAmount - 1)
        }
    }
    
}

extension InkGenerator {
    
    var randomCGFloat: CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    func randomInAbsoluteRange(min:CGFloat, max: CGFloat) -> CGFloat {
        let randomInRange = randomCGFloat * (max - min) + min
        
        if randomCGFloat >= 0.5 {
            return randomInRange
        }
        else {
            return randomInRange * -1.0
        }
    }
    
}
