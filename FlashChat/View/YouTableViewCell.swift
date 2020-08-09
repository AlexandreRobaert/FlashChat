//
//  YouTableViewCell.swift
//  FlashChat
//
//  Created by Alexandre Robaert on 08/08/20.
//  Copyright © 2020 Alexandre Robaert. All rights reserved.
//

import UIKit

class YouTableViewCell: UITableViewCell {

    @IBOutlet weak var messageBuble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        messageBuble.layer.cornerRadius = messageBuble.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
