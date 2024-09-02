//
//  NetflixDetailScrollView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 02/09/24.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailScrollView: View {
    var title: String = "Movie Title"
    var isNew: Bool = true
    var yearReleased: String? = "2024"
    var seasonCount: Int? = 2
    var hasClosedCaptions: Bool = true
    var ranking: Int? = 6
    var descriptionText: String? = "This is the description of the movie that is selected and it should go to multiple lines"
    var castText: String? = "Nick, Kunal, Someone else"
    var onPlayPressed: (() -> Void)? = nil
    var onDownloadPressed: (() -> Void)? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 8) {
                if isNew {
                    Text("New")
                        .foregroundStyle(.green)
                }
                
                if let yearReleased {
                    Text(yearReleased)
                }
                
                if let seasonCount {
                    Text("\(seasonCount) Seasons")
                }
                
                if hasClosedCaptions {
                    Image(systemName: "captions.bubble")
                }
            }
            .foregroundStyle(.netflixLightGray)
            
            if let ranking {
                HStack(spacing: 8) {
                    topTenIcon
                    
                    Text("#\(ranking) in TV Shows Today")
                        .font(.headline)
                }
            }
            
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Image(systemName: "play.fill")
                    Text("Play")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixDarkGray)
                .background(.netflixWhite)
                .cornerRadius(4)
                .asButton(.press) {
                    onPlayPressed?()
                }
                
                HStack {
                    Image(systemName: "arrow.down.to.line.alt")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
                .foregroundStyle(.netflixWhite)
                .background(.netflixDarkGray)
                .cornerRadius(4)
                .asButton(.press) {
                    onDownloadPressed?()
                }
            }
            .font(.callout)
            .fontWeight(.medium)
            
            Group {
                if let descriptionText {
                    Text(descriptionText)
                }
                
                if let castText {
                    Text(castText)
                        .foregroundStyle(.netflixLightGray)
                }
            }
            .font(.callout)
            .frame(maxWidth: .infinity, alignment: .leading)
            .multilineTextAlignment(.leading)
        }
        .foregroundStyle(.netflixWhite)
    }
    
    //MARK: - Top Ten Icon
    private var topTenIcon: some View {
        Rectangle()
            .fill(.netflixRed)
            .frame(width: 28, height: 28)
            .overlay (
                VStack(spacing: -4) {
                    Text("TOP")
                        .fontWeight(.bold)
                        .font(.system(size: 8))
                    
                    Text("10")
                        .fontWeight(.bold)
                        .font(.system(size: 16))
                }
                    .offset(y: 1)
            )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        VStack(spacing: 40) {
            NetflixDetailScrollView()
            
            NetflixDetailScrollView(
                isNew: false,
                yearReleased: nil,
                seasonCount: nil,
                hasClosedCaptions: false,
                ranking: nil,
                descriptionText: nil,
                castText: nil
            )
        }
    }
}
