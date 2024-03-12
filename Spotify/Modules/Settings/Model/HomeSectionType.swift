//
//  HomeSectionType.swift
//  Spotify
//
//  Created by rauan on 3/7/24.
//

import Foundation

enum HomeSectionType {
    case newRelseasedAlbums(datamodel: [AlbumsAndPlaylistsModel])
    case featuredPlaylists(datamodel: [AlbumsAndPlaylistsModel])
    case recommended(datamodel: [RecomendedModel])
}
