import Foundation

class RorschachTimer {
    
    var delegate: RorschachSaverView?

    func start() {
        Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
    }
    
    @objc
    func update() {
        delegate?.updateView()
    }
  
}

