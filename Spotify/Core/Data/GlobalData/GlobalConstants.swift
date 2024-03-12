//
//  GlobalConstants.swift
//  Spotify
//
//  Created by rauan on 2/28/24.
//

import Foundation

enum GlobalConstants {
    static let baseURL = "https://accounts.spotify.com"
    
    enum AuthAPI {
        static let clientID = "f4df2e8e198542639603c828ec15ed03"
        static let clientSecret = "05933b70c03345b7b2d44b7ccb97cac1"
        static let redirectURI = "https://open.spotify.com/"
        static let scopes = Scopes.allScopes.joined(separator: "%20")
    }
    
    enum Scopes {
//        static let userReadPrivate = "user-read-private"
        static let userReadPlaybackState = "user-read-playback-state"
        static let playlistModifyPublic = "playlist-modify-public"
        static let playlistModifyPrivate = "playlist-modify-private"
        static let userFollowRead = "user-follow-read"
        static let userLibraryModify = "playlist-modify-public"
        static let userReadEmail = "user-read-email"
        
        static let allScopes = [userReadPlaybackState,
                                playlistModifyPublic,
                                playlistModifyPrivate,
                                userFollowRead,
                                userLibraryModify,
                                userReadEmail
        ]
    }
    
}


