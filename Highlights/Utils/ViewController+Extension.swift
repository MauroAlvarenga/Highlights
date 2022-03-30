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
