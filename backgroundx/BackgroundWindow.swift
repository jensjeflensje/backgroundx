//
//  BackgroundWindow.swift
//  backgroundx
//
//  Created by Jens de Ruiter on 24/01/2023.
//

import Cocoa

class BackgroundWindow: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var window: NSWindow!
    var windows: Array<NSWindow> = []
    
    var controllers: Array<BackgroundViewController> = []

    func setWindow(url: URL, screens: Set<Screen>) {
        self.resetWindow()
        
        let title: String = "BackgroundX"
        let level: NSWindow.Level = NSWindow.Level(rawValue: Int(CGWindowLevelForKey(CGWindowLevelKey.desktopWindow)))
         
        for screen in screens {
            let window: NSWindow = NSWindow(contentRect: .init(origin: .zero,
                                                               size: .init(width: screen.screen.frame.width,
                                                                           height: screen.screen.frame.height)),
                                            styleMask: [.closable],
                                            backing: .buffered,
                                            defer: false,
                                            screen: screen.screen
            )
            
            window.title = title
            window.level = level
            window.isOpaque = false
            window.center()
            window.isMovableByWindowBackground = false
            //newWindow.backgroundColor = NSColor(calibratedHue: 0, saturation: 1.0, brightness: 0, alpha: 0.7)
            window.makeKeyAndOrderFront(nil)
            
            let controller: BackgroundViewController = BackgroundViewController(url: url)
            window.contentViewController = controller
            controllers.append(controller)
            
            var pos = NSPoint()
            pos.x = screen.screen.frame.minX
            pos.y = screen.screen.frame.minY
            window.setFrameOrigin(pos)
            
            windows.append(window)
        }
    }
    
    func resetWindow() {
        if (!self.controllers.isEmpty) {
            for controller in self.controllers {
                controller.close()
            }
            for window in self.windows {
                window.isReleasedWhenClosed = false
                window.close()
            }
            self.controllers.removeAll()
            self.windows.removeAll()
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
