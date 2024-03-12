//
//  RecommendedCollectionViewCell.swift
//  Spotify
//
//  Created by rauan on 3/7/24.
//

import UIKit

class RecommendedCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private enum Consraints {
        static let coverImageSize: CGFloat = 48
        static let coverImageCornerRadius: CGFloat = 24
        static let titleStackViewSpacing: CGFloat = 2
        static let optionsIconHeight: CGFloat = 24
        static let optionsIconWidth: CGFloat = 22
    }
    
    private lazy var coverImage: UIImageView = {
        let coverImage = UIImageView()
        coverImage.contentMode = .scaleAspectFill
        return coverImage
    }()
    
    private lazy var titleAndSubtitleStackView: UIStackView = {
        let titleAndSubtitleStackView = UIStackView()
        titleAndSubtitleStackView.axis = .vertical
        titleAndSubtitleStackView.spacing = 2
        titleAndSubtitleStackView.alignment = .fill
        titleAndSubtitleStackView.distribution = .fillEqually
        return titleAndSubtitleStackView
    }()
    
    private lazy var coverTitle: UILabel = {
        let coverTitle = UILabel()
        coverTitle.font = UIFont.systemFont(ofSize: 16)
        coverTitle.textColor = .white
        coverTitle.textAlignment = .left
        return coverTitle
    }()
    
    private lazy var coverSubtitle: UILabel = {
        let coverSubtitle = UILabel()
        coverSubtitle.font = UIFont.systemFont(ofSize: 13)
        coverSubtitle.textColor = .subtitle
        coverSubtitle.textAlignment = .left
        return coverSubtitle
    }()
    
    private lazy var optionsIcon: UIImageView = {
        let optionsIcon = UIImageView()
        optionsIcon.image = UIImage(named: "optionsIcon")
        optionsIcon.contentMode = .scaleAspectFit
        return optionsIcon
    }()
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    private func setupViews() {
        [coverImage, titleAndSubtitleStackView, optionsIcon].forEach {
            contentView.addSubview($0)
        }
        
        [coverTitle, coverSubtitle].forEach {
            titleAndSubtitleStackView.addArrangedSubview($0)
        }
        contentView.backgroundColor = .mainBackground
        
        coverImage.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(12)
            make.top.bottom.equalToSuperview().inset(8)
            make.size.equalTo(Consraints.coverImageSize)
        }
        titleAndSubtitleStackView.snp.makeConstraints { make in
            make.left.equalTo(coverImage.snp.right).offset(12)
            make.top.bottom.equalTo(coverImage)
        }
        optionsIcon.snp.makeConstraints { make in
            make.centerY.equalTo(coverImage.snp.centerY)
            make.right.equalToSuperview().inset(8)
            make.width.equalTo(Consraints.optionsIconWidth)
            make.height.equalTo(Consraints.optionsIconHeight)
        }
    }
    
    //MARK: - Configure cell
    func configure(with data: RecomendedModel) {
        coverImage.image = data.coverImage
        coverTitle.text = data.coverTitle
        guard let subtitle = data.coverSubtitle else {
            coverSubtitle.isHidden = true
            return
        }
        coverSubtitle.text = subtitle
    }
    
    
}
