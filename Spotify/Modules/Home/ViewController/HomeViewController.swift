//
//  ViewController.swift
//  Spotify
//
//  Created by rauan on 2/14/24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModel?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let contentView = UIView()
        return contentView
    }()
    
    private lazy var newReleasedAlbumsTitle: UILabel = {
        let newReleasedAlbumsTitle = UILabel()
        newReleasedAlbumsTitle.font = UIFont.systemFont(ofSize: 15)
        newReleasedAlbumsTitle.text = "New Released Albums"
        newReleasedAlbumsTitle.textColor = .white
        return newReleasedAlbumsTitle
    }()
    
    private lazy var newReleasedAlbumsCollectionView: UICollectionView = {
        var newReleasedAlbumsLayout = UICollectionViewFlowLayout()
        newReleasedAlbumsLayout.scrollDirection = .horizontal
        newReleasedAlbumsLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        newReleasedAlbumsLayout.minimumLineSpacing = 16
        
        let newReleasedAlbums = UICollectionView(frame: .zero, collectionViewLayout: newReleasedAlbumsLayout)
        newReleasedAlbums.showsHorizontalScrollIndicator = false
        newReleasedAlbums.showsVerticalScrollIndicator = false
        newReleasedAlbums.backgroundColor = .clear
        newReleasedAlbums.delegate = self
        newReleasedAlbums.dataSource = self
        newReleasedAlbums.register(AlbumsAndPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "newReleasedAlbumsCell")
        return newReleasedAlbums
    }()

    private lazy var featuredPlaylistsTitle: UILabel = {
        let featuredPlaylists = UILabel()
        featuredPlaylists.font = UIFont.systemFont(ofSize: 15)
        featuredPlaylists.text = "Featured Playlists"
        featuredPlaylists.textColor = .white
        return featuredPlaylists
    }()
    
    private lazy var featuredPlaylistsCollectionView: UICollectionView = {
        var featuredPlaylistsCollectionViewLayout = UICollectionViewFlowLayout()
        featuredPlaylistsCollectionViewLayout.scrollDirection = .horizontal
        featuredPlaylistsCollectionViewLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        featuredPlaylistsCollectionViewLayout.minimumLineSpacing = 16
        
        let featuredPlaylistsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: featuredPlaylistsCollectionViewLayout)
        featuredPlaylistsCollectionView.showsHorizontalScrollIndicator = false
        featuredPlaylistsCollectionView.showsVerticalScrollIndicator = false
        featuredPlaylistsCollectionView.backgroundColor = .clear
        featuredPlaylistsCollectionView.delegate = self
        featuredPlaylistsCollectionView.dataSource = self
        featuredPlaylistsCollectionView.register(AlbumsAndPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "featuredPlaylistsCell")
        return featuredPlaylistsCollectionView
    }()
    
    private lazy var recomendedTitle: UILabel = {
        let recomendedTitle = UILabel()
        recomendedTitle.font = UIFont.systemFont(ofSize: 15)
        recomendedTitle.text = "RecomendedTitle"
        recomendedTitle.textColor = .white
        return recomendedTitle
    }()
    
    private lazy var recomendedTableView: ContentSizedTableView = {
        let recomendedTableView = ContentSizedTableView()
        recomendedTableView.showsVerticalScrollIndicator = false
        recomendedTableView.separatorStyle = .none
        recomendedTableView.delegate = self
        recomendedTableView.dataSource = self
        recomendedTableView.backgroundColor = .clear
        recomendedTableView.register(RecomendedTableViewCell.self, forCellReuseIdentifier: "recomendedCell")
        return recomendedTableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    private func setupViewModel() {
        viewModel = HomeViewModel()
        viewModel?.loadNewReleasedAlbums(completion: {
            self.newReleasedAlbumsCollectionView.reloadData()
        })
        
        viewModel?.loadRecomended(completion: {
            self.recomendedTableView.reloadData()
        })
    }
    
    @objc
    func didTapSettings() {
    }
    
    private func setupViews() {
        
        
        navigationItem.title = "Home"
        
        let textColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textColor
        navigationController?.navigationBar.largeTitleTextAttributes = textColor
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        view.backgroundColor = .mainBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [newReleasedAlbumsTitle, newReleasedAlbumsCollectionView, featuredPlaylistsTitle, featuredPlaylistsCollectionView, recomendedTitle, recomendedTableView].forEach {
            contentView.addSubview($0)
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.bottom.right.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.centerX.equalTo(scrollView.snp.centerX)
            make.width.equalTo(view.frame.width)
        }
        
        newReleasedAlbumsTitle.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        newReleasedAlbumsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(newReleasedAlbumsTitle.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        featuredPlaylistsTitle.snp.makeConstraints { make in
            make.top.equalTo(newReleasedAlbumsCollectionView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        featuredPlaylistsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(featuredPlaylistsTitle.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview()
            make.height.equalTo(200)
        }
        
        recomendedTitle.snp.makeConstraints { make in
            make.top.equalTo(featuredPlaylistsCollectionView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        
        recomendedTableView.snp.makeConstraints { make in
            make.top.equalTo(recomendedTitle.snp.bottom).offset(16)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(contentView.snp.bottom)
        }
    }
    
}

//MARK: - CollectionViewDelegate and DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == newReleasedAlbumsCollectionView {
            return viewModel?.numberOfNewReleasedAlbums ?? 1
        } else {
            return viewModel?.numberOfNewReleasedAlbums ?? 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == newReleasedAlbumsCollectionView {
            let cell = newReleasedAlbumsCollectionView.dequeueReusableCell(withReuseIdentifier: "newReleasedAlbumsCell", for: indexPath) as! AlbumsAndPlaylistsCollectionViewCell
            let data = viewModel?.getCellViewModel(at: indexPath)
            cell.configure(data: data!)
            return cell
        } else {
            let cell = featuredPlaylistsCollectionView.dequeueReusableCell(withReuseIdentifier: "featuredPlaylistsCell", for: indexPath) as! AlbumsAndPlaylistsCollectionViewCell
            let data = viewModel?.getCellViewModel(at: indexPath)
            cell.configure(data: data!)
            return cell
        }
    }
}

//MARK: - TableViewDelegate and DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("coutn")
        return viewModel?.numberOfRecomended ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = recomendedTableView.dequeueReusableCell(withIdentifier: "recomendedCell", for: indexPath) as! RecomendedTableViewCell
        let data = viewModel?.getRecomendedCell(at: indexPath)
        cell.configure(with: data!)
        return cell
    }
}



