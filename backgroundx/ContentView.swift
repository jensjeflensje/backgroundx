//
//  ContentView.swift
//  backgroundx
//
//  Created by Jens de Ruiter on 24/01/2023.
//

import SwiftUI


struct Screen: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let screen: NSScreen
}


struct ContentView: View {
    
    @State private var url: String = ""
    @State private var chosenScreens = Set<Screen>()
    
    var currentWindow: BackgroundWindow = BackgroundWindow()
    
    var screens = [Screen]()
    
    init() {
        for screen in NSScreen.screens {
            let screenObj = Screen(name: screen.localizedName, screen: screen)
            screens.append(screenObj)
        }
    }
    
    func render() {
        let parsedURL = URL(string: url)
        if (parsedURL == nil) { return }
        currentWindow.setWindow(url: parsedURL!, screens: chosenScreens)
    }
    
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
            if #available(macOS 13.0, *) {
                List(self.screens, id: \.self, selection: $chosenScreens) { screen in
                    Text(screen.name)
                }
                .onAppear {
                    for screen in self.screens {
                        chosenScreens.insert(screen)
                    }
                }
            } else {
                Text("Screen selection is only available on macOS 13.0 and higher.")
            }
            Button(
              "Save",
              action: {
                  render()
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
