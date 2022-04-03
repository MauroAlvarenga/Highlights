//
//  ProductDetailCell.swift
//  Highlights
//
//  Created by Mauro Emmanuel Alvarenga on 02/04/2022.
//

import UIKit

class ProductDetailCell: UITableViewCell {

    // MARK: Properties
    
    //MARK: Outlets
    @IBOutlet weak var productImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: Actions
    @IBAction func buttonTap(_ sender: Any) {
        print("Button Tapped")
    }
    
}

// MARK: Public
extension ProductDetailCell {
    
    public func configure() {
        // TODO: Receive info from service and/or the previous view
    }
    
    public func setCellImage(_ img: UIImage) {
        productImageView.image = img
    }
    
}
