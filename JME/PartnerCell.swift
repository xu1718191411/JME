//
//  PartnerCell.swift
//  JME
//
//  Created by xuzhongwei on 2018/12/07.
//  Copyright © 2018 xuzhongwei. All rights reserved.
//

import UIKit

class PartnerCell: UITableViewCell {

    @IBOutlet weak var chatContent: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var chatView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
