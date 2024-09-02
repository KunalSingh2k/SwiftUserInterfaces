//
//  NetflixHomeView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 30/08/24.
//

import SwiftUI
import SwiftfulUI
import SwiftfulRouting

struct NetflixHomeView: View {
    @Environment(\.router) var router
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    @State private var fullHeaderSize: CGSize = .zero
    
    @State private var heroProduct: Product? = nil
    @State private var currentUser: User? = nil
    @State private var productRows: [ProductRow] = []
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            backgroundGradientLayer
            // Behind
            scrollViewLayer
            //Top
            headerViewWithFilter
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    //MARK: - Background layer gradients
    private var backgroundGradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixDarkGray.opacity(1), .netflixDarkGray.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            LinearGradient(colors: [.netflixDarkRed.opacity(0.5), .netflixDarkRed.opacity(0)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, (400 + (scrollViewOffset * 0.75))))
        .opacity(scrollViewOffset < -250 ? 0: 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    //MARK: - Header View
    private var headerView: some View {
        HStack(spacing: 0) {
            Text("For You")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .onTapGesture {
                    router.dismissScreen()
                }
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
    
    //MARK: - Scroll View Layer
    private var scrollViewLayer: some View {
        ScrollViewWithOnScrollChanged(
            .vertical,
            showsIndicators: false) {
                VStack(spacing: 8) {
                    Rectangle()
                        .opacity(0)
                        .frame(height: fullHeaderSize.height)
                    
                    if let heroProduct {
                        heroCell(product: heroProduct)
                    }
                    categoryRows
                }
            } onScrollChanged: { offset in
                scrollViewOffset = min(0, offset.y)
            }
    }
    
    //MARK: - Header View with Filter
    private var headerViewWithFilter: some View {
        // On Top
        VStack(spacing: 0) {
            headerView
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -20 {
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
                .padding(.top, 16)
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(.clear)
                        .background(.ultraThinMaterial)
                        .brightness(0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderSize == .zero {
                fullHeaderSize = frame.size
            }
        }
    }
    
    //MARK: - HeroCell
    private func heroCell(product: Product) -> some View {
        NetflixHeroCell(
            imageName: product.firstImage,
            isNetflixFilm: true,
            title: product.title,
            categories: [product.sku.capitalized, product.sku.capitalized],
            onBackgroundPressed: {
                onMoviePressed(product: product)
            },
            onPlayPressed: {
                onMoviePressed(product: product)
            },
            onMyListPressed: {
                
            }
        )
        .padding(24)
    }
    
    //MARK: - Category Rows
    private var categoryRows: some View {
        LazyVStack(spacing: 16) {
            ForEach(Array(productRows.enumerated()), id: \.offset) { (rowIndex, row) in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title.uppercased())
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding(.horizontal, 16)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { (index, product) in
                                NetflixMovieCell(
                                    imageName: product.firstImage,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: rowIndex == 1 ? (index + 1): nil
                                )
                                .onTapGesture {
                                    onMoviePressed(product: product)
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
    
}

#Preview {
    RouterView { _ in
        NetflixHomeView()
    }
}

//MARK: - Private functions
extension NetflixHomeView {
    private func getData() async {
        do {
            guard productRows.isEmpty else { return }
            currentUser = try await DatabaseHelper().getUsers().first
            let products = try await DatabaseHelper().getProducts()
            heroProduct = products.first
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map ({ $0.brand }))
            for brand in allBrands {
                //                let products = self.products.filter({$0.brand == brand})
                rows.append(ProductRow(title: brand?.capitalized ?? "Brand", products: products.shuffled()))
            }
            productRows = rows
            
        }catch {
            
        }
    }
    
    private func onMoviePressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMoviesDetailView(product: product)
        }
    }
}
