import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    private var window: NSWindow?
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let windowSize = NSSize(width: 1600, height: 900)
        let screenSize = NSScreen.main?.frame.size ?? .zero
        let rect = NSMakeRect(screenSize.width / 2 - windowSize.width / 2,
                              screenSize.height / 2 - windowSize.height / 2,
                              windowSize.width,
                              windowSize.height)
        window = NSWindow(contentRect: rect,
                          styleMask: [.closable, .titled],
                          backing: .buffered,
                          defer: false)
        window?.makeKeyAndOrderFront(nil)
        
        let testViewController = TestViewController()
        window?.contentViewController = testViewController
    }
    
}
