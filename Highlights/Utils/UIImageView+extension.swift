//
//  UIImageView+extension.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 05/04/2022.
//

import Foundation
import UIKit

extension UIImageView {
  func loadFrom(URLAddress: String) {
    guard let url = URL(string: URLAddress) else {
      return
    }
     
    DispatchQueue.main.async { [weak self] in
      if let imageData = try? Data(contentsOf: url) {
        if let loadedImage = UIImage(data: imageData) {
            self?.image = loadedImage
        }
      }
    }
  }
}
