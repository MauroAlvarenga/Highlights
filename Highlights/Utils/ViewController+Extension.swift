//
//  File.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

extension UIViewController {
    
    // Create instance By XIB
    static func genericInstance<T: UIViewController>() -> T {
        return T.init(nibName: String(describing: self), bundle: Bundle(for: self))
    }

    static func instance() -> Self {
        return genericInstance()
    }
}

class NavigationStyleHelper {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func setNavigationBarStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "primary")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black, .font: UIFont.init(name: "HelveticaNeue", size: 18)!]

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
