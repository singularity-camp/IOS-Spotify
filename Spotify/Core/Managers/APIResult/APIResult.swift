//
//  APIResult.swift
//  Spotify
//
//  Created by rauan on 2/28/24.
//

import Foundation

enum APIResult<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case networkFail
    case incorrectJSON
    case uknown
    case failedWith(error: String)
}
