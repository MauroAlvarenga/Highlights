//
//  FavoritesList.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 01/04/2022.
//

import Foundation

final class FavoritesList {
    
    static let shared = FavoritesList()
    private var favorites: [Int]
    
    private init() {
        let userDefaults = UserDefaults.standard
        if let savedFavorites = userDefaults.object(forKey: "favoritesList") as? [Int] {
            favorites = savedFavorites
        } else {
            favorites = [Int]()
        }
    }

    func getFavorites() -> [Int] {
        return self.favorites
    }
    
    func addFavorite(_ newFavorite: Int) {
        favorites.append(newFavorite)
    }
    
    func removeFavorite(_ oldFavorite: Int) {
        favorites.removeAll { $0 == oldFavorite }
    }
    
}
