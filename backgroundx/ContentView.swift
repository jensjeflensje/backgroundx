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

extension Array: RawRepresentable where Element: Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}

struct ContentView: View {
    
    @AppStorage("url") private var url: String = ""
    @AppStorage("screens") private var storedChosenScreens: Array<String> = []
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
        storedChosenScreens.removeAll()
        for chosenScreen in chosenScreens {
            storedChosenScreens.append(chosenScreen.name)
        }
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
                    if (storedChosenScreens.isEmpty) {
                        for screen in self.screens {
                            chosenScreens.insert(screen)
                        }
                    } else {
                        for screen in Set(self.storedChosenScreens) {
                            for nsScreen in self.screens {
                                if nsScreen.name == screen {
                                    self.chosenScreens.insert(nsScreen)
                                    break;
                                }
                            }
                        }
                    }
                }
            } else {
                Text("Screen selection is only available on macOS 13.0 and higher.")
                    .onAppear {
                        for screen in self.screens {
                            chosenScreens.insert(screen)
                        }
                    }
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
