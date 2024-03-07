//
//  MainViewModel.swift
//  Spotify
//
//  Created by rauan on 2/14/24.
//

import UIKit

class HomeViewModel {
    private lazy var newReleasedAlbums: [AlbumsAndPlaylistsModel] = []
    private lazy var featuredPlaylists: [AlbumsAndPlaylistsModel] = []
    private lazy var recomended: [RecomendedModel] = []
    
    private lazy var sections = [HomeSectionType]()
    
    var numberOfNewReleasedAlbums: Int {
        return newReleasedAlbums.count
    }
    
    var numberOfRecomended: Int {
        return recomended.count
    }
    var numberOfSections :Int {
        return sections.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> AlbumsAndPlaylistsModel {
        return newReleasedAlbums[indexPath.row]
    }
    
    func getRecomendedCell(at indexPath: IndexPath) -> RecomendedModel {
        return recomended[indexPath.row]
    }
    
    
    func loadNewReleasedAlbums(completion: () -> ()) {
        let albums: [AlbumsAndPlaylistsModel] = [
            .init(coverImage: UIImage(named: "cover1")!, coverTitle: "Anand Bakshi: The Lyricist Who Made…"),
            .init(coverImage: UIImage(named: "cover2")!, coverTitle: "E123: Sankar Bora (Co-founder & CO…"),
            .init(coverImage: UIImage(named: "cover3")!, coverTitle: "Hymn for the Weekend"),
            .init(coverImage: UIImage(named: "cover4")!, coverTitle: "Something Just Like This"),
            .init(coverImage: UIImage(named: "cover5")!, coverTitle: "A Rush of Blood to the Head"),
        ]
        
        self.newReleasedAlbums = albums
        completion()
    }
    
    func loadRecomended(completion: () -> ()) {
        let albums: [RecomendedModel] = [
            .init(coverImage: UIImage(named: "cover5")!, coverTitle: "Cozy Coffeehouse", coverSubtitle: nil),
            .init(coverImage: UIImage(named: "cover4")!, coverTitle: "Cozy", coverSubtitle: "Profile"),
            .init(coverImage: UIImage(named: "cover3")!, coverTitle: "Cozy Clouds", coverSubtitle: nil),
            .init(coverImage: UIImage(named: "cover2")!, coverTitle: "Kanye West", coverSubtitle: "Dark Fantasy"),
            .init(coverImage: UIImage(named: "cover1")!, coverTitle: "Basta", coverSubtitle: "Basta 2")
        ]
        
        self.recomended = albums
        completion()
    }
    
    func loadData(completion: ([HomeSectionType]) -> ()) {
        sections.append(.newRelseasedAlbums(datamodel: [
            .init(coverImage: UIImage(named: "cover1")!, coverTitle: "Anand Bakshi: The Lyricist Who Made…"),
            .init(coverImage: UIImage(named: "cover2")!, coverTitle: "E123: Sankar Bora (Co-founder & CO…"),
            .init(coverImage: UIImage(named: "cover3")!, coverTitle: "Hymn for the Weekend"),
            .init(coverImage: UIImage(named: "cover4")!, coverTitle: "Something Just Like This"),
            .init(coverImage: UIImage(named: "cover5")!, coverTitle: "A Rush of Blood to the Head"),
        ]))
        sections.append(.featuredPlaylists(datamodel: [
            .init(coverImage: UIImage(named: "cover3")!, coverTitle: "Hymn for the Weekend"),
            .init(coverImage: UIImage(named: "cover4")!, coverTitle: "Something Just Like This"),
            .init(coverImage: UIImage(named: "cover5")!, coverTitle: "A Rush of Blood to the Head"),
            .init(coverImage: UIImage(named: "cover1")!, coverTitle: "Anand Bakshi: The Lyricist Who Made…"),
            .init(coverImage: UIImage(named: "cover2")!, coverTitle: "E123: Sankar Bora (Co-founder & CO…"),
            
        ]))
        sections.append(.recommended(datamodel: [
            .init(coverImage: UIImage(named: "cover5")!, coverTitle: "Cozy Coffeehouse", coverSubtitle: nil),
            .init(coverImage: UIImage(named: "cover4")!, coverTitle: "Cozy", coverSubtitle: "Profile"),
            .init(coverImage: UIImage(named: "cover3")!, coverTitle: "Cozy Clouds", coverSubtitle: nil),
            .init(coverImage: UIImage(named: "cover2")!, coverTitle: "Kanye West", coverSubtitle: "Dark Fantasy"),
            .init(coverImage: UIImage(named: "cover1")!, coverTitle: "Basta", coverSubtitle: "Basta 2")
        ]))
        
        completion(sections)
        
        
    }
    
    
    
    
}
