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
            Button("Open Spotify") {
                router.showScreen(.fullScreenCover) { _ in
                    SpotifyHomeView()
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
