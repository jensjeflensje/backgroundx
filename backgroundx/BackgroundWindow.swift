//
//  BackgroundWindow.swift
//  backgroundx
//
//  Created by Jens de Ruiter on 24/01/2023.
//

import Cocoa

class BackgroundWindow: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    lazy var newWindow: NSWindow = NSWindow(contentRect: .init(origin: .zero,
                                               size: .init(width: NSScreen.main!.frame.maxX,
                                                           height: NSScreen.main!.frame.maxY)),
                            styleMask: [.closable],
                            backing: .buffered,
                            defer: false
   )
    
    var controller: BackgroundViewController?
    
    func setWindow(url: String) {
        self.resetWindow()
        
        
        self.newWindow.title = "BackgroundX"
        
        self.newWindow.level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.desktopWindow)))
        self.newWindow.isOpaque = false
        
        self.newWindow.center()
        self.newWindow.isMovableByWindowBackground = false
        //newWindow.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)
        self.newWindow.makeKeyAndOrderFront(nil)
        
        self.controller = BackgroundViewController(url: url)
        self.newWindow.contentViewController = self.controller
    }
    
    func resetWindow() {
        if (self.controller != nil) {
            self.controller?.close()
            self.controller = nil
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
