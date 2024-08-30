//
//  ContentView.swift
//  swiftUIDesign
//
//  Created by Kunal Kumar R on 28/08/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    
    var body: some View {
        List {
            // Open spotify
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
                }
            }
            // Open Bumble
            Button("Open Bumble") {
                router.showScreen(.fullScreenCover) { _ in
                    BumbleHomeView()
                }
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        ContentView()
    }
    
}
