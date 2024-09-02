//
//  NetflixFilterBarView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 30/08/24.
//

import SwiftUI


struct FilterModel: Hashable, Equatable {
    let title: String
    let isDropDown: Bool
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropDown: false),
            FilterModel(title: "Movies", isDropDown: false),
            FilterModel(title: "Categories", isDropDown: true),
        ]
    }
}

struct NetflixFilterBarView: View {
    var selectedFilter: FilterModel? = nil
    var filters: [FilterModel] = FilterModel.mockArray
    var onXMarkPressed: (() -> Void)? = nil
    var onFilterPressed: ((FilterModel) -> Void)? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onXMarkPressed?()
                        }
                        .transition(AnyTransition.move(edge: .leading))
                        .padding(.leading, 16)
                }
                
                ForEach(filters, id: \.self) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropDown: filter.isDropDown,
                            isSelected: selectedFilter == filter
                        )
                        .background(.black.opacity(0.001))
                        .onTapGesture {
                            onFilterPressed?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && filter == filters.first) ? 16: 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .scrollIndicators(.hidden)
        .animation(.bouncy, value: selectedFilter)
    }
}


// Preview purposes
fileprivate struct NetflixFilterBarPreview: View {
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    var body: some View {
        NetflixFilterBarView(
            selectedFilter: selectedFilter,
            filters: filters,
            onXMarkPressed: {
                selectedFilter = nil
            },
            onFilterPressed:  { newFilter in
                selectedFilter = newFilter
            }
        )
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        
        NetflixFilterBarPreview()
    }
}
