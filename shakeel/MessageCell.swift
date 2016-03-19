//
//  MessageCell.swift
//  shakeel
//
//  Created by Tejen Hasmukh Patel on 3/18/16.
//  Copyright © 2016 ccsf. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var backgroundSuperview: UIView!
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundSuperview.layer.cornerRadius = 15
        backgroundSuperview.clipsToBounds = true
        messageImageView.layer.cornerRadius = 15
        messageImageView.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
