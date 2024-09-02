//
//  RateButton.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 02/09/24.
//

import SwiftUI

enum RateOption: String, CaseIterable {
    case dislike, like, love
    
    // Title
    var title: String {
        switch self {
        case .dislike:
            "Not for me"
        case .like:
            "I like this"
        case .love:
            "Love this!"
        }
    }
    
    // Icon
    var icon: String {
        switch self {
        case .dislike:
            "hand.thumbsdown"
        case .like:
            "hand.thumbsup"
        case .love:
            "bolt.heart"
        }
    }
}

struct RateButton: View {
    @State private var showPopover: Bool = false
    var onRatingSelected: ((RateOption) -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "hand.thumbsup")
                .font(.title)
            
            Text("Rate")
                .font(.caption)
                .foregroundStyle(.netflixLightGray)
        }
        .foregroundStyle(.netflixWhite)
        .padding(8)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopover.toggle()
        }
        .popover(isPresented: $showPopover, content: {
            ZStack {
                Color.netflixDarkGray.ignoresSafeArea()
                
                HStack(spacing: 12) {
                    ForEach(RateOption.allCases, id: \.self) { option in
                        rateButton(option: option)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
            }
            .presentationCompactAdaptation(.popover)
        })
    }
    
    //MARK: - Rate Button method
    /// returns some view
    private func rateButton(option: RateOption) -> some View {
        VStack {
            Image(systemName: option.icon)
                .font(.title2)
            Text(option.title)
                .font(.caption)
            
        }
        .foregroundStyle(.netflixWhite)
        .padding(4)
        .background(.black.opacity(0.001))
        .onTapGesture {
            showPopover = false
            onRatingSelected?(option)
        }
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        RateButton()
    }
}
