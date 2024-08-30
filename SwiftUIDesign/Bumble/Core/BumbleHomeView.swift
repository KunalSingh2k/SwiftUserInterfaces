//
//  BumbleHomeView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 29/08/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct BumbleHomeView: View {
    // Variables
    @Environment(\.router) var router
    @State private var filters: [String] = ["Everyone", "Trending"]
    @State private var allUsers: [User] = []
    @State private var selectedIndex: Int = 0
    @State private var cardOffests: [Int:Bool] = [:] // UserID : (Direction is right == TRUE)
    @State private var currentSwipeOffset: CGFloat = 0
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    //MARK: - Body of Bumble Home View
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 12) {
                header
                
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                ZStack {
                    if !allUsers.isEmpty {
                        ForEach(Array(allUsers.enumerated()), id: \.offset) { (index, user) in
                            
                            let isPrevious = (selectedIndex - 1) == index
                            let isCurrent = (selectedIndex) == index
                            let isNext = (selectedIndex + 1) == index
                            
                            if isPrevious || isCurrent || isNext {
                                let offsetValue = cardOffests[user.id]
                                userProfileCell(user: user, index: index)
                                    .zIndex(Double(allUsers.count - index))
                                    .offset(x: offsetValue == nil ? 0: offsetValue == true ? 900: -900)
                            }
                        }
                    }else {
                        ProgressView()
                    }
                    
                    overlaySwipingIndicators
                        .zIndex(102)
                }
                .frame(maxHeight: .infinity)
                .padding(4)
                .animation(.smooth, value: cardOffests)
                
                Spacer()
            }
            .padding(8)
        }
        .task {
            await getAllUsers()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    //MARK: - Header
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        router.dismissScreen()
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "ellipsis.message.fill")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        BumbleChatView()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    //MARK: - User Profile cell
    private func userProfileCell(user: User, index: Int) -> some View {
        BumbleCardView(
            user: user,
            superLikePressed: nil,
            xmarkPressed: {
                userDidSelect(index: index, isLike: false)
            },
            checkmarkPressed: {
                userDidSelect(index: index, isLike: true)
            },
            sendComplimentPressed: nil,
            hideAndReportPressed: { }
        )
        .withDragGesture(
            .horizontal,
            minimumDistance: 10,
            resets: true,
            //                animation: ,
            rotationMultiplier: 1.05,
            scaleMultiplier: 0.8,
            onChanged: { dragOffset in
                currentSwipeOffset = dragOffset.width
            },
            onEnded: { dragOffset in
                if dragOffset.width < -75 {
                    userDidSelect(index: index, isLike: false)
                }else if dragOffset.width > 75 {
                    userDidSelect(index: index, isLike: true)
                }
            }
        )
    }
    
    //MARK: - Overlay Swiping Indicators
    private var overlaySwipingIndicators: some View {
        ZStack {
            // X-Mark
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay (
                    Image(systemName: "xmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5: 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: -100)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // CheckMark
            Circle()
                .fill(.bumbleGray.opacity(0.4))
                .overlay (
                    Image(systemName: "checkmark")
                        .font(.title)
                        .fontWeight(.semibold)
                )
                .frame(width: 60, height: 60)
                .scaleEffect(abs(currentSwipeOffset) > 100 ? 1.5: 1.0)
                .offset(x: min(-currentSwipeOffset, 150))
                .offset(x: 100)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .animation(.smooth, value: currentSwipeOffset)
    }
    
}

#Preview {
    RouterView { _ in
        BumbleHomeView()
    }
}


//MARK: - Private Functions
extension BumbleHomeView {
    // Get All Users function
    private func getAllUsers() async {
        do {
            guard allUsers.isEmpty else { return }
            allUsers = try await DatabaseHelper().getUsers()
            
        }catch {
            
        }
    }
    
    // User did select function
    private func userDidSelect(index: Int, isLike: Bool) {
        let user = allUsers[index]
        cardOffests[user.id] = isLike
        
        selectedIndex += 1
    }
}
