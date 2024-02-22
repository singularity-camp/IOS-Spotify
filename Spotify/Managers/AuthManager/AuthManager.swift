//
//  AuthManager.swift
//  Spotify
//
//  Created by rauan on 2/22/24.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    struct Constants {
        static let clientID = "f4df2e8e198542639603c828ec15ed03"
        static let clientSecret = "05933b70c03345b7b2d44b7ccb97cac1"
    }
    
    public var signInURL: URL? {
        let baseURL = "https://accounts.spotify.com/authorize"
        let scopes = "user-read-private"
        let redirectURI = "https://open.spotify.com/"
        let completeURL =  "\(baseURL)?response_type=code&client_id=\(Constants.clientID)&scope=\(scopes)&redirect_uri=\(redirectURI)&show_dialog=TRUE"
        return URL(string: completeURL)
    }
    
    var isSignedIn: Bool {
        return false
    }
    
    private init(){}
    
    private var accessToken: String? {
        return nil
    }
    
    private var refreshToken: String? {
        return nil
    }
    
    private var tokenExpirationDate: Date? {
        return nil
    }
    
    private var shouldRefreshToken: Bool {
        return false
    }
    
    private func exchangeCodeForToken(code: String, completion: @escaping((Bool) -> Void)) {
        
    }
    
    private func refreshAccessToken() {
        
    }
    
    private func cacheToken() {
        
    }
    
}
