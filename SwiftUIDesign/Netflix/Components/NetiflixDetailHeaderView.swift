//
//  NetiflixDetailHeaderView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 02/09/24.
//

import SwiftUI
import SwiftfulUI

struct NetiflixDetailHeaderView: View {
    var imageName: String = Constants.randomImage
    var progress: Double = 0.3
    var onAirPlayButtonPressed: (() -> Void)? = nil
    var onXmarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoaderView(urlString: imageName)
            
            CustomProgressBar(
                selection: progress,
                range: 0...1,
                backgroundColor: .netflixLightGray,
                foregroundColor: .netflixRed,
                cornerRadius: 2,
                height: 4
            )
            .padding(.bottom, 4)
            .animation(.linear, value: progress)
            
            HStack(spacing: 8) {
                // AirPlay Button
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay (
                        Image(systemName: "tv.badge.wifi")
                            .offset(y: 1)
                    )
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        onAirPlayButtonPressed?()
                    }
                
                // Close Button
                Circle()
                    .fill(.netflixDarkGray)
                    .overlay (
                        Image(systemName: "xmark")
                            .offset(y: 1)
                    )
                    .frame(width: 36, height: 36)
                    .onTapGesture {
                        onXmarkPressed?()
                    }
            }
            .foregroundStyle(.netflixWhite)
            .font(.subheadline)
            .padding(8)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

#Preview {
    NetiflixDetailHeaderView()
}
