//
//  InterestPillView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 29/08/24.
//

import SwiftUI

struct InterestPillView: View {
    
    var iconName: String? = "heart.fill"
    var emoji: String? = "🤙"
    var text: String = "Degree"
    
    var body: some View {
        HStack(spacing: 4) {
            if let iconName {
                Image(systemName: iconName)
            }else if let emoji {
                Text(emoji)
            }
            
            Text(text)
        }
        .font(.callout)
        .fontWeight(.medium)
        .padding(.vertical, 6)
        .padding(.horizontal, 16)
        .foregroundStyle(.bumbleBlack)
        .background(.bumbleYellow.opacity(0.4))
        .cornerRadius(32)
    }
}

#Preview {
    VStack {
        InterestPillView(iconName: nil)
        InterestPillView()
    }
}
