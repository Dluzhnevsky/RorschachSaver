import ScreenSaver

class RorschachSaverView: ScreenSaverView {
   
    let rorschachTimer: RorschachTimer
    
    var inkGenerator: InkGenerator
    var inkSpots: [InkSpot]
    
    override init?(frame: NSRect, isPreview: Bool) {
        rorschachTimer = RorschachTimer()
        
        inkGenerator = InkGenerator(rect: frame)
        inkSpots = [InkSpot]()
        inkSpots.append(inkGenerator.makeNextInkSpot())
      
        super.init(frame: frame, isPreview: isPreview)
        rorschachTimer.delegate = self
        rorschachTimer.start()
    }
    
    func updateView() {
        
        inkSpots.append(inkGenerator.makeNextInkSpot())
        needsDisplay = true
    }

    override func draw(_ rect: NSRect) {
        NSColor.white.set()
        rect.fill()
        
        for (index, inkSpot) in inkSpots.enumerated().reversed() {
            inkSpot.update(rect)
            
            if inkSpot.isGone {
                inkSpots.remove(at: index)
            }
        }
        
        NSColor.yellow.set()
        ("\(inkSpots.count)" as NSString).draw(in: NSRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.height), withAttributes: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
