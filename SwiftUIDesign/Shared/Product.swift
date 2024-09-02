//
//  Product.swift
//  swiftUIDesign
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation

struct Products: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title, description: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let brand: String?
    let sku: String
    let weight: Int
    let minimumOrderQuantity: Int
    let images: [String]
    let thumbnail: String
    
    var firstImage: String {
        images.first ?? Constants.randomImage
    }
    
    let recentlyAdded: Bool  = {
        return Int.random(in: 1...4) == 1
    }()
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "Example porduct description",
            price: 999,
            discountPercentage: 900,
            rating: 4.5,
            stock: 50,
            tags: ["AAAA"],
            brand: "Apple",
            sku: "Playlist",
            weight: 12,
            minimumOrderQuantity: 2,
            images: [Constants.randomImage, Constants.randomImage, Constants.randomImage],
            thumbnail: Constants.randomImage
        )
    }
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
