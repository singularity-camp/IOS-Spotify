//
//  AuthTarget.swift
//  Spotify
//
//  Created by rauan on 2/26/24.
//

import Foundation
import Moya

enum AuthTarget {
    case getAccessToken(code: String)
    case shouldRefreshToken(refreshToken: String)
}

extension AuthTarget: BaseTargetType {
    var path: String {
        return "/api/token"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self  {
        case .getAccessToken(let code):
            return .requestParameters(
                parameters: [ "grant_type": "authorization_code",
                              "code": code,
                              "redirect_uri": GlobalConstants.AuthAPI.redirectURI
            
            ], encoding: URLEncoding.default)
        case .shouldRefreshToken(let refreshToken):
            return .requestParameters(
                parameters: ["grant_type" : "refresh_token",
                             "refresh_token" : refreshToken,
                             "client_id" : GlobalConstants.AuthAPI.clientID
                            ],
                
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        var headers = [String: String]()
        let authString = "\(GlobalConstants.AuthAPI.clientID):\(GlobalConstants.AuthAPI.clientSecret)"
        guard let authData = authString.data(using: .utf8) else {
            print("Failure to get base64")
            return nil }
        
        let base64AuthString = authData.base64EncodedString()
        headers["Authorization"] = "Basic \(base64AuthString)"
        headers["Content-Type"] = "application/x-www-form-urlencoded"
        return headers
    }
    
}
