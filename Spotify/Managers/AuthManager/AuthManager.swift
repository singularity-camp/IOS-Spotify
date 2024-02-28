//
//  AuthManager.swift
//  Spotify
//
//  Created by Mariya Aliyeva on 22.02.2024.
//

import Foundation
import SwiftKeychainWrapper
import Moya

final class AuthManager {
	
	static let shared = AuthManager()
	private let provider = MoyaProvider<AuthTarget>(
		plugins: [
			NetworkLoggerPlugin(configuration: NetworkLoggerPluginConfig.prettyLogging),
			LoggerPlugin()
		]
	)
	
	public var signInURL: URL? {
		let baseURL = GlobalConstants.baseURL + "/authorize"
		
		var components = URLComponents(string: baseURL)
		
		components?.queryItems = [
			URLQueryItem(name: "response_type", value: "code"),
			URLQueryItem(name: "client_id", value: GlobalConstants.AuthApi.clientId),
			URLQueryItem(name: "scope", value: GlobalConstants.AuthApi.scopes),
			URLQueryItem(name: "redirect_uri", value: GlobalConstants.AuthApi.redirectUri),
			URLQueryItem(name: "show_dialog", value: "TRUE")
		]
		return components?.url
	}
	
	var isSignedIn: Bool {
		return accessToken != nil
	}
	
	private init() {}
	
	private var accessToken: String? {
		return KeychainWrapper.standard.string(forKey: "accessToken")
	}
	
	private var refreshToken: String? {
		return KeychainWrapper.standard.string(forKey: "refreshToken")
	}
	
	private var tokenExpirationDate: Date? {
		return UserDefaults.standard.object(forKey: "expirationDate") as? Date
	}
	
	private var shouldRefreshToken: Bool {
		guard let tokenExpirationDate else {return false}
		let currentDate = Date()
		let fiveMinutes: TimeInterval = 300
		return currentDate.addingTimeInterval(fiveMinutes) >= tokenExpirationDate
	}
	
	func exchangeCodeForToken(
		code: String,
		completion: @escaping ((APIResult<Void>) -> ())
	){
		
		provider.request(.getAccessToken(code: code)) { [weak self] result in
			switch result {
			case .success(let response):
				guard let result = try? response.map(AuthResponse.self) else {
					completion(.failure(.incorrectJson))
					return
				}
				self?.cacheToken(result: result)
				completion(.success(()))
			case .failure(let error):
				completion(.failure(.failedWith(error: error.localizedDescription)))
			}
		}
	}
	
	func refreshIfNeeded(
		code: String,
		completion: @escaping ((Bool) -> Void)
	) {
		
		guard shouldRefreshToken else {
			return
		}
		provider.request( .getRefreshToken(code: code)) { [weak self] result in
			switch result {
			case .success(let response):
				guard let result = try? response.map(AuthResponse.self) else {
					completion(false)
					return
				}
				self?.cacheToken(result: result)
				completion(true)
			case .failure(_):
				completion(false)
			}
		}
	}
		
	private func cacheToken(result: AuthResponse) {
		KeychainWrapper.standard.set(result.accessToken, forKey: "accessToken")
		
		if let refreshToken = result.refreshToken {
			KeychainWrapper.standard.set(refreshToken, forKey: "refreshToken")
		}
		
		UserDefaults.standard.set(Date().addingTimeInterval(TimeInterval(result.expiresIn)), forKey: "expirationDate")
	}
}
