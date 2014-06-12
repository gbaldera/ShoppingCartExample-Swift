//
//  ProductCell.swift
//  ShoppingCart
//
//  Created by Jose Gustavo Rodriguez Baldera on 6/5/14.
//  Copyright (c) 2014 Jose Gustavo Rodriguez Baldera. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet var productImage : UIImageView = nil
    
    init(style: UITableViewCellStyle, reuseIdentifier: String) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
