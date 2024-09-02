//
//  NetflixMoviesDetailView.swift
//  SwiftUIDesign
//
//  Created by Kunal Kumar R on 02/09/24.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMoviesDetailView: View {
    @Environment(\.router) var router
    
    var product: Product = .mock
    @State private var progress: Double = 0.2
    @State private var isMyList: Bool = false
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack {
                NetiflixDetailHeaderView(
                    imageName: product.firstImage,
                    progress: progress,
                    onAirPlayButtonPressed: {
                        
                    },
                    onXmarkPressed: {
                        router.dismissScreen()
                    }
                )
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        movieDetailSection
                        
                        buttonSection
                        
                        movieGridSection
                    }
                    .padding(8)
                }
                .scrollIndicators(.hidden)
            }
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    //MARK: - Movie Detail Section
    private var movieDetailSection: some View {
        NetflixDetailScrollView(
            title: product.title,
            isNew: true,
            yearReleased: "2024",
            seasonCount: 4,
            hasClosedCaptions: true,
            ranking: 6,
            descriptionText: product.description,
            castText: "Cast: Nick, Kunal, someone Else",
            onPlayPressed: {
                
            },
            onDownloadPressed: {
                
            }
        )
    }
    
    //MARK: - Button section
    private var buttonSection: some View {
        HStack(spacing: 32) {
            MyListButton(isMyList: isMyList) {
                isMyList.toggle()
            }
            
            RateButton { selection in
                // do something with selections
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
    }
    
    //MARK: - Movie Grid Section
    private var movieGridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3),
                      alignment: .center,
                      spacing: 8,
                      content: {
                ForEach(products) { product in
                    NetflixMovieCell(
                        imageName: product.firstImage,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded
                    )
                    .onTapGesture {
                        onMoviePressed(product: product)
                    }
                }
            })
        }
        .foregroundStyle(.netflixWhite)
    }
}

#Preview {
    RouterView { _ in
        NetflixMoviesDetailView()
    }
}


//MARK: - Private functions
extension NetflixMoviesDetailView {
    private func getData() async {
        do {
            guard products.isEmpty else { return }
            products = try await DatabaseHelper().getProducts()
        }catch {
            
        }
    }
    
    private func onMoviePressed(product: Product) {
        router.showScreen(.sheet) { _ in
            NetflixMoviesDetailView(product: product)
        }
    }
}
