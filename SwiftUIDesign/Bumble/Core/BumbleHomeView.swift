//
//  BumbleHomeView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 29/08/24.
//

import SwiftUI

struct BumbleHomeView: View {
    
    @State private var filters: [String] = ["Everyone", "Trending"]
    @AppStorage("bumble_home_filter") private var selectedFilter = "Everyone"
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 12) {
                header
                
                BumbleFilterView(options: filters, selection: $selectedFilter)
                    .background(Divider(), alignment: .bottom)
                
                BumbleCardView()
                
                Spacer()
            }
            .padding(8)
        }
    }
    
    //MARK: - Header
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.001))
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
}

#Preview {
    BumbleHomeView()
}
