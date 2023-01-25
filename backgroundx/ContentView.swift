//
//  ContentView.swift
//  backgroundx
//
//  Created by Jens de Ruiter on 24/01/2023.
//

import SwiftUI



func loadWebPage(url: String) {
    
}

struct ContentView: View {
    
    @State private var url: String = ""
    
    var currentWindow: BackgroundWindow = BackgroundWindow()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Put in a URL to get started")
            TextField(
                "Website URL",
                text: $url
            )
            Button(
              "Open as wallpaper",
              action: {
                  DispatchQueue.main.async {
                    currentWindow.setWindow(url: url)
                  }
              }
            )
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
