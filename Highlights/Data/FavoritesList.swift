//
//  FavoritesList.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 01/04/2022.
//

import Foundation

final class FavoritesList {
    
    static let shared = FavoritesList()
    private var favorites: Set<String>
    
    private init() {
        let userDefaults = UserDefaults.standard
        if let savedFavorites = userDefaults.object(forKey: "favoritesList") as? [String] {
            favorites = Set(savedFavorites)
        } else {
            favorites = []
        }
    }

    func getFavorites() -> Set<String> {
        return self.favorites
    }
    
    func addFavorite(_ newFavorite: String) {
        favorites.insert(newFavorite)
    }
    
    func removeFavorite(_ oldFavorite: String) {
        favorites.remove(oldFavorite)
    }
    
}
