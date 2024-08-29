//
//  SwiftUIDesignApp.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 28/08/24.
//

import SwiftUI
import SwiftfulRouting

@main
struct SwiftUIDesignApp: App {
    var body: some Scene {
        WindowGroup {
            RouterView { _ in
                ContentView()
            }
        }
    }
}


extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        viewControllers.count > 1
    }
}
