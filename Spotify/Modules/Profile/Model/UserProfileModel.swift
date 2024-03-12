//
//  UserProfileModel.swift
//  Spotify
//
//  Created by rauan on 3/1/24.
//

import Foundation

// MARK: - UserProfileModel
struct UserProfileModel: Codable {
    let country, displayName: String?
    let images: [Image]
    let product: String?

    enum CodingKeys: String, CodingKey {
        case country
        case displayName = "display_name"
        case images, product
    }
}


// MARK: - Image
struct Image: Codable {
    let url: String
    let height, width: Int
}
