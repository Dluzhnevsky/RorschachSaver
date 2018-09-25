import Cocoa

class InkGenerator {
    
    static let idlingTime = 50
    static let showingTime = 150
    
    static let defaultInkAmount = 250
    
     enum State {
        case idling
        case painting
        case showing
    }
    
    private var x: CGFloat = 0
    private var y: CGFloat = 0
    private var radius: CGFloat = 0
    private var brightness:CGFloat = 0
    private var rect: NSRect
    
     var state: State
    private var timerTick: NSInteger
    
    var inkSpots: [InkSpot]
    
    init(rect: NSRect) {
        self.rect = rect
        
        self.state = .idling
        self.timerTick = 0
        
        inkSpots = [InkSpot]()
    }
    
    func setup() {
        self.radius = Randomizer.randomCGFloat * 50 + 20
        self.x = Randomizer.randomCGFloat * rect.width / 2.0
        self.y = Randomizer.randomCGFloat * rect.height
        self.brightness = Randomizer.randomCGFloat / 2.0 + 0.5
    }
    
    func update() {
        switch state {
        case .idling:
            self.timerTick += 1
            if timerTick >= InkGenerator.idlingTime {
                startPainting()
                timerTick = 0
                state = .painting
            }
        case .painting:
            for InkSpot in inkSpots {
                if !InkSpot.wasCreated {
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
    
    func startPainting() {
        setup()
        proceedAppendingInkSpots(with: InkGenerator.defaultInkAmount)
    }
    
    func eraseAll() {
        for inkSpot in inkSpots {
            inkSpot.shouldBeGone = true
        }
    }
    
    func proceedAppendingInkSpots(with currentInkAmount: NSInteger) {
        let inkSpot = InkSpot(x: x, y: y, width: radius, height: radius)
        
        radius += Randomizer.randomCGFloat * 64.0 - 32.0
        
        if radius < 32.0 {
            radius = 32.0
        }
        
        if radius > 192.0 {
            radius = 192.0
        }
        
        x += Randomizer.randomInAbsoluteRange(min: 16.0, max: 32.0)
        
        if x < 0 {
            x = 0
        }
        else if x > rect.width / 2.0 {
            x = rect.width / 2.0
        }
        
        y += Randomizer.randomInAbsoluteRange(min: 16.0, max: 32.0)
        
        if y < 0 {
            y = 0
        }
        else if y > rect.height - radius {
            y = rect.height - radius
        }
        
        brightness += Randomizer.randomCGFloat * 0.2 - 0.1
        
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
    
    func draw(_ rect: NSRect) {
        
        for (index, inkSpot) in inkSpots.enumerated().reversed() {
            inkSpot.update(rect)
            
            if inkSpot.isGone {
                inkSpots.remove(at: index)
            }
        }
        
    }
    
}
