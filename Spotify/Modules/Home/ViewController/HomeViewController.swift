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
    
    private var sections = [HomeSectionType]()
    
    private lazy var compositionLayout: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            self.createCompostionalLayout(section: sectionIndex)
            
        }
        
        let compositionLayout = UICollectionView(frame: .zero, collectionViewLayout: layout)
        compositionLayout.delegate = self
        compositionLayout.dataSource = self
        compositionLayout.showsVerticalScrollIndicator = false
        compositionLayout.showsVerticalScrollIndicator = false
        compositionLayout.backgroundColor = .clear
        compositionLayout.register(AlbumsAndPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        compositionLayout.register(RecommendedCollectionViewCell.self, forCellWithReuseIdentifier: "recommendedCell")
        return compositionLayout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
        setupNavigationBar()
    }
    
    private func setupViewModel() {
        viewModel = HomeViewModel()
        viewModel?.loadNewReleasedAlbums(completion: {
//            self.newReleasedAlbumsCollectionView.reloadData()
        })
        
        viewModel?.loadRecomended(completion: {
//            self.recomendedTableView.reloadData()
        })
        
        viewModel?.loadData(completion: { loadedSections in
            sections = loadedSections
        })
        
    }

    private func setupNavigationBar() {
        
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        navigationBarAppearance.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        navigationBarAppearance.backgroundColor = .mainBackground
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.compactAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        
        let textColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textColor
        navigationController?.navigationBar.largeTitleTextAttributes = textColor
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: self, action: #selector(didTapSettings))
        navigationItem.rightBarButtonItem?.tintColor = .white
        navigationItem.setBackBarItem()
        
    }
    
    private func createCompostionalLayout(section: Int) -> NSCollectionLayoutSection {
        switch section {
            
        case 0:
//            Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 2, leading: 0, bottom: 2, trailing: 2)
            
            //        Group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(168),
                    heightDimension: .absolute(220)),
                repeatingSubitem: item,
                count: 1)
            //        Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.contentInsets = .init(top: 8, leading: 16, bottom: 4, trailing: 16)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case 1:
//            Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 2, leading: 0, bottom: 2, trailing: 2)
            
            //        Group
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(168),
                    heightDimension: .absolute(220)),
                repeatingSubitem: item,
                count: 1)
            //        Section
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.contentInsets = .init(top: 4, leading: 16, bottom: 4, trailing: 16)
            section.orthogonalScrollingBehavior = .continuous
            return section
            
        case 2:
//            Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 2, leading: 0, bottom: 2, trailing: 2)
            
            //        Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70)),
                repeatingSubitem: item,
                count: 1)
            //        Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.contentInsets = .init(top: 4, leading: 16, bottom: 16, trailing: 16)
            return section
            
        default:
//            Item
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            item.contentInsets = .init(top: 2, leading: 2, bottom: 2, trailing: 2)
            
            
            //        Group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(70)),
                repeatingSubitem: item,
                count: 1)
            //        Section
            let section = NSCollectionLayoutSection(group: verticalGroup)
            section.contentInsets = .init(top: 4, leading: 16, bottom: 4, trailing: 16)
            return section
            
        }
        
    }
    private func setupViews() {
        
        view.backgroundColor = .mainBackground
        navigationItem.title = "Home"
        
        view.addSubview(compositionLayout)
        
        compositionLayout.snp.makeConstraints { make in
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
        }

    }  
    
    @objc
    func didTapSettings() {
        let settings = SettingsViewController()
        settings.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(settings, animated: true)
        
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfSections ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sections[section] {
        case .newRelseasedAlbums(let dataModel):
            return dataModel.count
        case .featuredPlaylists(let dataModel):
            return dataModel.count
        case .recommended(let dataModel):
            return dataModel.count
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .newRelseasedAlbums(let dataModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumsAndPlaylistsCollectionViewCell
            cell.configure(data: dataModel[indexPath.row])
            return cell
            
        case .featuredPlaylists(let dataModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AlbumsAndPlaylistsCollectionViewCell
            cell.configure(data: dataModel[indexPath.row])
            return cell
        case .recommended(let dataModel):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recommendedCell", for: indexPath) as! RecommendedCollectionViewCell
            cell.configure(with: dataModel[indexPath.row])
            return cell
        }
    }
}


