//
//  IntrestGridView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 29/08/24.
//

import SwiftUI
import SwiftfulUI

struct UserInterest: Identifiable {
    let id = UUID().uuidString
    var iconName: String? = nil
    var emoji: String? = nil
    var text: String
}

struct IntrestGridView: View {
    
    var interests: [UserInterest] = User.mock.Interests
    
    var body: some View {
        ZStack {
            NonLazyVGrid(
                columns: 2,
                alignment: .leading,
                spacing: 8,
                items: interests) { interest in
                    if let interest {
                        InterestPillView(
                            iconName: interest.iconName,
                            emoji: interest.emoji,
                            text: interest.text
                        )
                    }else {
                        EmptyView()
                    }
                }
        }
    }
}

#Preview {
    VStack(spacing: 40) {
        IntrestGridView(interests: User.mock.Interests)
        IntrestGridView(interests: User.mock.basics)
        
    }
}
