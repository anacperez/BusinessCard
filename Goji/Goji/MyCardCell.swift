//
//  MyCardCell.swift
//  Goji
//
//  Created by Naelin Aquino on 11/23/16.
//  Copyright © 2016 Anae. All rights reserved.
//

import UIKit

class MyCardCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    var card: Card! {
        didSet {
            titleLabel.text = card.first
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


}
