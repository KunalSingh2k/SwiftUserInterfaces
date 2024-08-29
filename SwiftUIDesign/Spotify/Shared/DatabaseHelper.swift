//
//  DatabaseHelper.swift
//  swiftUIDesign
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation

struct DatabaseHelper {
    
    // Get products
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(Products.self, from: data)
        return products.products
    }
    
    // Get users
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(Users.self, from: data)
        return users.users
    }
}






