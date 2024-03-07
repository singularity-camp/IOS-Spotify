//
//  AuthManager.swift
//  Spotify
//
//  Created by rauan on 2/22/24.
//

import Foundation
import Moya
import SwiftKeychainWrapper

final class AuthManager {
    static let shared = AuthManager()
    private let provider = MoyaProvider<AuthTarget>(
        plugins: [
            NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
            LoggerPlugin()
        ]
    )
    
    private var refreshingToken = false
    private var onRefreshBlocks = [(String) -> Void]()
    
    public var signInURL: URL? {
        
        var components = URLComponents(string: GlobalConstants.baseURL + "/authorize")
        components?.queryItems = [
            URLQueryItem(name: "response_type", value: "code"),
            URLQueryItem(name: "client_id", value: GlobalConstants.AuthAPI.clientID),
            URLQueryItem(name: "scope", value: GlobalConstants.AuthAPI.scopes),
            URLQueryItem(name: "redirect_uri", value: GlobalConstants.AuthAPI.redirectURI),
            URLQueryItem(name: "show_dialog", value: "TRUE"),
        ]
        onRefreshBlocks.forEach({ callback in
            callback("")
        })
        return components?.url
        
    }
    
    var isSignedIn: Bool {
        return accessToken != nil
    }
    
    private init(){}
    
    private var accessToken: String? {
        return KeychainWrapper.standard.string(forKey: "accessToken")
        
    }
    
    private var refreshToken: String? {
        return KeychainWrapper.standard.string(forKey: "refreshToken")
    }
    
    private var tokenExpirationDate: Date? {
        return UserDefaults.standard.object(forKey: "expiresIn") as? Date
    }
    
    private var shouldRefreshToken: Bool {
        guard let tokenExpirationDate else { return false }
        let currentDate = Date()
        let fiveMinutes: TimeInterval = 300
        print("shouldRefreshStatus: \(currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirationDate)")
        return currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirationDate
    }
    
    func exchangeCodeForToken(code: String, completion: @escaping((APIResult<Void>) -> ())) {
        provider.request(.getAccessToken(code: code)) { [weak self] result in
            switch result {
            
            case .success(let response):
                guard let result = try? response.map(AuthResponse.self) else {
                    completion(.failure(.incorrectJSON))
                    return
                }
                        
                self?.cacheToken(result: result)
                print("json: \(result)")
                completion(.success(()))
            case .failure(let error):
                completion(.failure(.failedWith(error: error.localizedDescription)))
            }
        }
    }
    
    public func withValidToken(completion: @escaping (String) -> Void) {
        
        guard !refreshingToken else {
            onRefreshBlocks.append(completion)
            return
        }
        
        if shouldRefreshToken {
            
            refreshAccessToken { [weak self] success in
                if success, let accessToken = self?.accessToken {
                    completion(accessToken)
                }
            }
        } else {
            
            guard let accessToken else { return }
            completion(accessToken)
        }
    }
    
    func refreshAccessToken(completion: ((Bool) -> Void)? = nil) {
        guard !refreshingToken else {
            return
        }
        
        guard shouldRefreshToken else {
            completion?(true)
            return
        }
        
        refreshingToken = true
        
        guard let refreshToken else { return }
        
        provider.request(.shouldRefreshToken(refreshToken: refreshToken)) { [weak self] result in
            self?.refreshingToken = false
            switch result {
            case .success(let response):
                do {
                    let result = try JSONDecoder().decode(AuthResponse.self, from: response.data)
                    
                    self?.onRefreshBlocks.forEach{ $0(result.accessToken)}
                    print("successfully refreshed")
                    self?.onRefreshBlocks.removeAll()
                    self?.cacheToken(result: result)
                    completion?(true)
                    
                }
                catch {
                    print(error.localizedDescription)
                    completion?(false)
                }
                
            case .failure(let error):
                print(error)
                completion?(false)
            }
        }
    }
    
    private func cacheToken(result: AuthResponse) {
        KeychainWrapper.standard.set(result.accessToken, forKey: "accessToken")
        
        if let refreshToken = result.refreshToken {
            KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
        }
        UserDefaults.standard.setValue(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expiresIn")
    }
    
}
