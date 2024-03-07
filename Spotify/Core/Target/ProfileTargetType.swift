//
//  ProfileTargetType.swift
//  Spotify
//
//  Created by rauan on 3/1/24.
//

import Foundation

enum ProfileTargetType {
    case getProfileInfo
}

extension ProfileTargetType: BaseTargetType {
    var baseURL: URL {
        return URL(string: "https://api.spotify.com")!
    }
    var path: String {
        return "/v1/me"
    }
    var headers: [String : String]? {
        var header = [String: String]()
        AuthManager.shared.withValidToken { token in
            header["Authorization"] = "Bearer \(token)"
        }
        return header
    }
    
    
    
}
