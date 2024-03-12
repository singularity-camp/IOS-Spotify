//
//  albumsAndPlaylistsCollectionViewCell.swift
//  Spotify
//
//  Created by rauan on 2/14/24.
//

import UIKit

class AlbumsAndPlaylistsCollectionViewCell: UICollectionViewCell {
    
    private let coverImage: UIImageView = {
        let coverImage = UIImageView()
        coverImage.contentMode = .scaleAspectFill
        coverImage.clipsToBounds = true
        return coverImage
    }()
    
    private let coverTitle: UILabel = {
        let coverTitle = UILabel()
        coverTitle.textColor = .white
        coverTitle.font = UIFont.systemFont(ofSize: 15)
        coverTitle.textAlignment = .left
        coverTitle.numberOfLines = 2
        return coverTitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        contentView.clipsToBounds = true
        [coverImage, coverTitle].forEach{
            contentView.addSubview($0)
        }
        
        contentView.snp.makeConstraints { make in
            make.height.equalTo(200)
            make.width.equalTo(160)
        }
        
        coverImage.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(152)
            make.width.equalTo(152)
        }
        
        coverTitle.snp.makeConstraints { make in
            make.top.equalTo(coverImage.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(145)
        }
    }
    
    func configure(data: AlbumsAndPlaylistsModel) {
        coverImage.image = data.coverImage
        coverTitle.text = data.coverTitle
    }
    
}
