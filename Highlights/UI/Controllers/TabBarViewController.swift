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
             
        // Set the first tab Controller
        let homeVC = HomeViewController.instance()
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
        
        // Test product detail view. TODO: remove in production
        let productVC = ProductDetailViewController()
        productVC.title = "Producto"
        let pVCrightItem1 = barButtonFromImage("CartEmpty24")
        let pVCrightItem2 = barButtonFromImage("Search24")
        let rightItem3 = barButtonFromImage("FavoriteOutlined24")
        productVC.navigationItem.rightBarButtonItems = [pVCrightItem1, pVCrightItem2, rightItem3]
        let productNavigationController = UINavigationController(rootViewController: productVC)
        let productTabBarItem = UITabBarItem(title: "Producto", image: UIImage(named: "CartEmpty24"), selectedImage: nil)
        productNavigationController.tabBarItem = productTabBarItem
        
        // Add controllers to TabBar
        viewControllers = [homeNavigationController, favoritesNavigationController, productNavigationController]
        
        // Setup Tab Bar and Search appeareance
        setTabBarAppeareance(self.tabBar)
    }

}

// MARK: Appeareance Methods
extension TabBarViewController {
    
    public func setTabBarAppeareance(_ tabBar: UITabBar) {
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
    
    private func barButtonFromImage (_ name: String) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: name), style: .plain, target: .none, action: .none)
    }
    
}
