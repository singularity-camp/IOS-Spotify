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
        setupTabbarAppearance()
    }
    
    //MARK: - Setting tabbar
    private func setupTabbar() {
        view.backgroundColor = .black
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let searchViewController = UINavigationController(rootViewController: SearchViewController())
        let libraryViewController = UINavigationController(rootViewController: LibraryViewController())
        
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        libraryViewController.tabBarItem = UITabBarItem(title: "Library", image: UIImage(named: "icon_library"), tag: 1)
        
        let viewControllers: [UINavigationController] = [homeViewController, searchViewController, libraryViewController]
        
        viewControllers.forEach {
            $0.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(viewControllers, animated: false)
    }
    
    private func setupTabbarAppearance() {
        
        let tabbarAppearance = UITabBarAppearance()
        tabbarAppearance.configureWithOpaqueBackground()
        tabbarAppearance.backgroundColor = .black
        tabBar.standardAppearance = tabbarAppearance
        tabBar.scrollEdgeAppearance = tabbarAppearance
        view.backgroundColor = .black
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.unselectedItemTintColor = .lightGray
    }

}
