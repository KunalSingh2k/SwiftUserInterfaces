//
//  BumbleHeartView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 29/08/24.
//

import SwiftUI

struct BumbleHeartView: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(.bumbleYellow)
                .frame(width: 40, height: 40)
            
            Image(systemName: "bubble.fill")
                .foregroundStyle(.bumbleBlack)
                .font(.system(size: 22))
                .offset(y: 2)
            
            Image(systemName: "heart.fill")
                .foregroundStyle(.bumbleYellow)
                .font(.system(size: 10))
        }
    }
}

#Preview {
    BumbleHeartView()
}
