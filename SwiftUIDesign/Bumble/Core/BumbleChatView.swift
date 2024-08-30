//
//  BumbleChatView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 30/08/24.
//

import SwiftUI
import SwiftfulRouting

struct BumbleChatView: View {
    
    @Environment(\.router) var router
    @State private var allUsers: [User] = []
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 0) {
                headerView
                    .padding(16)
                matchQueueSection
                    .padding(.vertical, 16)
                chatsSection
                Spacer()
            }
        }
        .task {
            await getAllUsers()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    //MARK: - Header View
    private var headerView: some View {
        HStack(spacing: 3) {
            Image(systemName: "line.horizontal.3")
                .onTapGesture {
                    router.dismissScreen()
                }
            Spacer(minLength: 0)
            Image(systemName: "magnifyingglass")
        }
        .font(.title)
        .fontWeight(.medium)
        
    }
    
    //MARK: - MatchQueue Section
    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                Text("Match Queue")
                +
                Text("(\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        BumbleProfileImageCell(
                            imageName: user.image,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random()
                        )
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 100)
            .scrollIndicators(.hidden)
            
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
    
    //MARK: - Chats Section
    private var chatsSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                Group {
                    Text("Chats")
                    +
                    Text("(Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                Spacer(minLength: 0)
                
                Image(systemName: "line.horizontal.3.decrease")
                    .font(.title2)
            }
            .padding(.horizontal, 16)
            
            ScrollView(.vertical) {
                LazyVStack(spacing: 16) {
                    ForEach(allUsers) { user in
                        BumbleChatPreviewCell(
                            imageName: user.image,
                            percentageRemaining: Double.random(in: 0...1),
                            hasNewMessage: Bool.random(),
                            userName: user.firstName,
                            lastChatMessage: user.aboutMe,
                            isYourMove: Bool.random()
                        )
                    }
                }
                .padding(16)
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
    }
}

#Preview {
    BumbleChatView()
}


extension BumbleChatView {
    // Get All Users function
    private func getAllUsers() async {
        do {
            guard allUsers.isEmpty else { return }
            allUsers = try await DatabaseHelper().getUsers()
            
        }catch {
            
        }
    }
}
