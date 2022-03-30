//
//  TableViewCell.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 30/03/2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var favoriteButton: UIButton!
    var hasTappedButton: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Actions
    @IBAction func didTapFavoriteButton(_ sender: UIButton) {
        if hasTappedButton {
            favoriteButton.setImage(UIImage(named: "FavoriteFilled16"), for: .normal)
            hasTappedButton = false
        } else {
            favoriteButton.setImage(UIImage(named: "FavoriteOutlined16"), for: .normal)
            hasTappedButton = true
        }
    }
    
    public func hideFavoriteButton() {
        favoriteButton.isHidden = true
    }
}
