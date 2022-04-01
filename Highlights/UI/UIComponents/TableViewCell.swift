//
//  TableViewCell.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Properties
    private var hasTappedButton: Bool = false
    private var ID: Int?
    let userDefaults = UserDefaults()
    var favoritesList = FavoritesList.shared
    
    // MARK: Outlets
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Actions
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        if !hasTappedButton {
            // Button was tapped
            hasTappedButton = true
            favoriteButton.setImage(UIImage(named: "FavoriteFilled16"), for: .normal)
            if let id = self.ID {
                favoritesList.addFavorite(id)
                print("Added something")
                print(favoritesList.getFavorites())
            }
        } else {
            // For the case when the button gets tapped again
            hasTappedButton = false
            favoriteButton.setImage(UIImage(named: "FavoriteOutlined16"), for: .normal)
            userDefaults.removeObject(forKey: "favoriteItemID")
            if let id = self.ID {
                favoritesList.removeFavorite(id)
                print("Removed something")
                print(favoritesList.getFavorites())
            }
        }
    }
    
    func setCellImage(_ img: UIImage) {
        self.cellImage.image = img
    }
    
    func hideFavoriteButton() {
        self.favoriteButton.isHidden = true
    }
    
    func setCellID(_ id: Int) {
        self.ID = id
    }
}
