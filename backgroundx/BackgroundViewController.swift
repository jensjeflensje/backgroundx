//
//  BackgroundViewController.swift
//  backgroundx
//
//  Created by Jens de Ruiter on 25/01/2023.
//

import Cocoa
import WebKit

class BackgroundViewController: NSViewController {
    
    var url: URL?

    var webView: WKWebView {
        return view as! WKWebView
    }
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func close() {
        self.view.removeFromSuperview()
        self.removeFromParent()
    }

    override func loadView() {
        super.loadView()
        let config = WKWebViewConfiguration()
        config.preferences.setValue(true, forKey: "allowsInlineMediaPlayback")
        view = WKWebView(frame:self.view.frame, configuration: config)
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.window?.screen?.frame.width ?? 1920, height: self.view.window?.screen?.frame.height ?? 1080)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.load(URLRequest(url: self.url!))
    }
}
