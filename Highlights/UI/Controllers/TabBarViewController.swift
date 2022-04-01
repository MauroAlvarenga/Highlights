//
//  TabBarViewController.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

class TabBarViewController: UITabBarController {


    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    func setupViewControllers() {
             
        // Prepare the search Controller for the first controller
        let searchController = UISearchController()
        
        // Set the first tab Controller
        let homeVC = HomeViewController.instance()
        // Add Search Bar to the first view
        homeVC.navigationItem.titleView = searchController.searchBar
        // Set right bar Item
        homeVC.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "CartEmpty24"), style: .plain, target: .none, action: .none)
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        let homeTabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "Home24"), selectedImage: nil)
        homeNavigationController.tabBarItem = homeTabBarItem
        
        // Set the second tab Controller
        let favoritesVC = FavoritesViewController.instance()
        favoritesVC.title = "Favoritos"
        // Set right bar Items
        let rightItem1 = UIBarButtonItem(image: UIImage(named: "CartEmpty24"), style: .plain, target: .none, action: .none)
        let rightItem2 = UIBarButtonItem(image: UIImage(named: "Search24"), style: .plain, target: .none, action: .none)
        favoritesVC.navigationItem.rightBarButtonItems = [rightItem1, rightItem2]
        let favoritesNavigationController = UINavigationController(rootViewController: favoritesVC)
        let favoritesTabBarItem = UITabBarItem(title: "Favoritos", image: UIImage(named: "FavoriteOutlined24"), selectedImage: nil)
        favoritesNavigationController.tabBarItem = favoritesTabBarItem
        
        // Add controllers to TabBar
        viewControllers = [homeNavigationController, favoritesNavigationController]
        
        // Setup Navigation, Tab Bar and Search appeareance
        setNavBarAppeareance(homeNavigationController.navigationBar)
        setNavBarAppeareance(favoritesNavigationController.navigationBar)
        setTabBarAppeareance(self.tabBar)
        setSearchControllerAppeareance(searchController)
    }

}

extension TabBarViewController {
    
    func setNavBarAppeareance(_ navbar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        //appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .yellowML
        appearance.titleTextAttributes = [.foregroundColor: UIColor.textPrimary, .font: UIFont(name: "Proxima Nova", size: 24)!]
        navbar.tintColor = .textPrimary
        navbar.standardAppearance = appearance
        navbar.scrollEdgeAppearance = appearance
        navbar.compactAppearance = appearance
        // NavBar Shadow
        navbar.layer.shadowColor = UIColor.lightGray.cgColor
        navbar.layer.shadowOpacity = 0.7
        navbar.layer.shadowOffset = CGSize(width: 0, height: 2)
        navbar.layer.shadowRadius = 2
        
    }
    
    func setTabBarAppeareance(_ tabBar: UITabBar) {
        let appearance = UITabBarAppearance()
        //appearance.configureWithDefaultBackground()
        appearance.backgroundColor = .backgroundWhite
        appearance.compactInlineLayoutAppearance.normal.iconColor = .textPrimary
        appearance.compactInlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.textPrimary, .font: UIFont(name: "Proxima Nova", size: 12)!]
        
        appearance.inlineLayoutAppearance.normal.iconColor = .textPrimary
        appearance.inlineLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.textPrimary, .font: UIFont(name: "Proxima Nova", size: 12)!]
        
        appearance.stackedLayoutAppearance.normal.iconColor = .darkText
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor : UIColor.textPrimary, .font: UIFont(name: "Proxima Nova", size: 12)!]
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        tabBar.tintColor = .accentML
    }
    
    func setSearchControllerAppeareance(_ searchController: UISearchController) {
        searchController.searchBar.tintColor = .textPrimary
        searchController.searchBar.searchTextField.layer.cornerRadius = 20
        searchController.searchBar.searchTextField.layer.masksToBounds = true
        searchController.searchBar.searchTextField.backgroundColor = .backgroundWhite
        searchController.searchBar.searchTextField.placeholder = "Buscar en Mercado Libre"
        searchController.searchBar.setValue("Cancelar", forKey: "cancelButtonText")
    }
}
