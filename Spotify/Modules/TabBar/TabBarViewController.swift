//
//  TabBarViewController.swift
//  Spotify
//
//  Created by rauan on 2/22/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    //MARK: - Setting tabbar
    private func setupTabbar() {
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let libraryViewController = UINavigationController(rootViewController: LibraryViewController())
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        libraryViewController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(named: "icon_library"), tag: 1)
        
        let viewControllers: [UINavigationController] = [homeViewController, searchViewController, libraryViewController]
        
        tabBar.tintColor = .white
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .black
        viewControllers.forEach {
            $0.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(viewControllers, animated: false)

    }

}
