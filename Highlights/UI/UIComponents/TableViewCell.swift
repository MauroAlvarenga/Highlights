//
//  TableViewCell.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Properties
    var hasTappedButton: Bool = false
    
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
        if hasTappedButton {
            favoriteButton.setImage(UIImage(named: "FavoriteOutlined16"), for: .normal)
            hasTappedButton = false
        } else {
            favoriteButton.setImage(UIImage(named: "FavoriteFilled16"), for: .normal)
            hasTappedButton = true
        }
    }
    
    func setCellImage(_ img: UIImage) {
        self.cellImage.image = img
    }
    
    func hideFavoriteButton() {
        self.favoriteButton.isHidden = true
    }
}
