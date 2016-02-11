//
//  CartTableViewCell.swift
//  SPA
//
//  Created by Coder on 2/3/16.
//  Copyright © 2016 OWA. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartLabel: UILabel!
    @IBOutlet weak var cartQuantityLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cartQuantityLabel.textAlignment = .Center
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
