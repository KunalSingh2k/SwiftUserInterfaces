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
    
    var work: String {
        "Works at some job"
    }
    
    var education: String {
        "Student at college"
    }
    var aboutMe: String {
        "This is sentence about me which will look good on my profile"
    }
    
    var basics: [UserInterest] {
        [
            UserInterest(iconName: "ruler", emoji: nil, text: "\(height)"),
            UserInterest(iconName: "graduationcap", emoji: nil, text: "\(education)"),
            UserInterest(iconName: "wineglass", emoji: nil, text: "Socially"),
            UserInterest(iconName: "moons.stars.fill", emoji: nil, text: "Virgo"),
        ]
    }
    
    var Interests: [UserInterest] {
        [
            UserInterest(iconName: nil, emoji: "👟", text: "Running"),
            UserInterest(iconName: nil, emoji: "🏋️‍♀️", text: "Gym"),
            UserInterest(iconName: nil, emoji: "🎧", text: "Music"),
            UserInterest(iconName: nil, emoji: "🍳", text: "Cooking"),
        ]
    }
    
    var images: [String] {
        [
            "https://picsum.photos/400/400",
            "https://picsum.photos/500/500",
            "https://picsum.photos/600/600",
        ]
    }
    
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
