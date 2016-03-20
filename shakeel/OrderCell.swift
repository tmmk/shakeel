//
//  OrderCell.swift
//  shakeel
//
//  Created by mny on 3/19/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var orderNumLabel: UILabel!
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var problemDescriptionLabel: UILabel!
    @IBOutlet weak var shippingETAlabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
