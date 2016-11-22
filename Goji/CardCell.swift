//
//  CardCell.swift
//  Goji
//
//  Created by Naelin Aquino on 11/17/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit

class CardCell: UITableViewCell {
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    var card: Card! {
        didSet {
            firstNameLabel.text = card.first
            emailLabel.text = card.email
            ratingImageView.image = imageForRating(rating: 5)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func imageForRating(rating:Int) -> UIImage? {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }

}
