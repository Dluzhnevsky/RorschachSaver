import ScreenSaver

class RorschachSaverView: ScreenSaverView {
   
    let rorschachTimer: RorschachTimer
    
    var inkGenerator: InkGenerator
    
    override init?(frame: NSRect, isPreview: Bool) {
        rorschachTimer = RorschachTimer()
        
        inkGenerator = InkGenerator(rect: frame)
      
        super.init(frame: frame, isPreview: isPreview)
        rorschachTimer.delegate = self
        rorschachTimer.start()
    }
    
    func updateView() {
        needsDisplay = true
        inkGenerator.update()
    }

    override func draw(_ rect: NSRect) {
        NSColor.white.set()
        rect.fill()
       
        inkGenerator.draw(rect)
        
        ("\(inkGenerator.state)" as NSString).draw(in: NSRect(x: 0.0, y: 0.0, width: self.frame.size.width, height: self.frame.height), withAttributes: nil)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
