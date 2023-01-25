//
//  BackgroundViewController.swift
//  backgroundx
//
//  Created by Jens de Ruiter on 25/01/2023.
//

import Cocoa
import WebKit

class BackgroundViewController: NSViewController {
    
    var url = ""

    var webView: WKWebView {
        return view as! WKWebView
    }
    
    init(url: String) {
        super.init(nibName: nil, bundle: nil)
        self.url = url
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func close() {
        self.view.window?.windowController?.close()
    }

    override func loadView() {
        super.loadView()
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "allowsInlineMediaPlayback")
        view = WKWebView(frame:self.view.frame, configuration: config)
        let screenSize = NSScreen.main
        self.view.frame = CGRect(x: 0, y: 0, width: screenSize?.frame.width ?? 1920, height: screenSize?.frame.height ?? 1080)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.url != "") {
            webView.load(URLRequest(url: URL(string: self.url)!))
        }
    }
}
