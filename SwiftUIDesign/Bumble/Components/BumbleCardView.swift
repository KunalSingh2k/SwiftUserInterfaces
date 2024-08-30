//
//  BumbleCardView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 29/08/24.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    
    var user: User = .mock
    var superLikePressed: (() -> Void)? = nil
    var xmarkPressed: (() -> Void)? = nil
    var checkmarkPressed: (() -> Void)? = nil
    var sendComplimentPressed: (() -> Void)? = nil
    var hideAndReportPressed: (() -> Void)? = nil
    @State private var cardFrame: CGRect = .zero
    
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                
                userInfoCell
                    .frame(height: cardFrame.height)
                
                aboutMeSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                myInterestSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                locationSection
                    .padding(.horizontal, 24)
                    .padding(.vertical, 24)
                
                footerSection
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 32)
                
                
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay (
            superLikeButton
                .padding(24)
            ,alignment: .bottomTrailing
        )
        .cornerRadius(32)
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    //MARK: - User Info cell
    private var userInfoCell: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    Text(user.work)
                }
                
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    Text(user.education)
                }
                
                BumbleHeartView()
                    .onTapGesture { }
            }
            .padding(24)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
    }
    
    //MARK: - SuperLike Button
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay (
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30))
                    .fontWeight(.medium)
            )
    }
    
    //MARK: - About Me section
    private var aboutMeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0) {
                BumbleHeartView()
                
                Text("Send a compliment")
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding([.horizontal, .trailing], 8)
            .background(.bumbleYellow)
            .cornerRadius(32)
            .onTapGesture {
                sendComplimentPressed?()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - My interests section
    private var myInterestSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My basics")
                IntrestGridView(interests: user.basics)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My Interests")
                IntrestGridView(interests: user.Interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Location section
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            Text("10 miles away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emoji: "🇮🇳", text: "Lives in India")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    //MARK: - Footer Section
    private var footerSection: some View {
        VStack(spacing: 24) {
            HStack(spacing: 0) {
                Circle()
                    .fill(.bumbleYellow)
                    .overlay (
                        Image(systemName: "xmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        xmarkPressed?()
                    }
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(.bumbleYellow)
                    .overlay (
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    )
                    .frame(width: 60, height: 60)
                    .onTapGesture {
                        checkmarkPressed?()
                    }
            }
            Text("Hide and report")
                .font(.headline)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    hideAndReportPressed?()
                }
        }
    }
}


#Preview {
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}


extension BumbleCardView {
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
}
