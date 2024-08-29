//
//  User.swift
//  swiftUIDesign
//
//  Created by Kunal Kumar R on 28/08/24.
//

import Foundation

struct Users: Codable {
    let users: [User]
    let total, skip, limit: Int
}

struct User: Codable, Identifiable {
    let id: Int
    let firstName, lastName: String
    let age: Int
    let email, phone, username, password: String
    let birthDate: String
    let image: String
    let height, weight: Double
    
    static var mock: User {
        User(
            id: 444,
            firstName: "Kunal",
            lastName: "R",
            age: 22,
            email: "hi@hi.com",
            phone: "",
            username: "",
            password: "",
            birthDate: "",
            image: Constants.randomImage,
            height: 180,
            weight: 200
        )
    }
}
