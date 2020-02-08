import ScreenSaver

class RorschachSaverView: ScreenSaverView {
    
    // MARK: - Private Static Properties
    
    private static let updateTimerInterval: TimeInterval = 0.04
    
    // MARK: - Private Properties
    
    private var inkGenerator: InkGenerator?
    private var updateTimer: Timer?
    
    // MARK: - Lifecycle
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        commonInit()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        commonInit()
    }
    
    override func draw(_ rect: NSRect) {
        inkGenerator?.drawUpdatedFrame(in: rect)
    }
    
    // MARK: - Private Methods
    
    private func commonInit() {
        inkGenerator = InkGenerator(rect: frame)
        startTimer()
    }
    
    private func startTimer() {
        updateTimer = Timer.scheduledTimer(timeInterval: RorschachSaverView.updateTimerInterval,
                                           target: self,
                                           selector: #selector(updateView),
                                           userInfo: nil,
                                           repeats: true)
    }
    
    @objc
    private func updateView() {
        needsDisplay = true
    }
    
}
