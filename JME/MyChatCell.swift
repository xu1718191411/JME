//
//  MyChatCell.swift
//  JME
//
//  Created by xuzhongwei on 2018/12/07.
//  Copyright © 2018 xuzhongwei. All rights reserved.
//

import UIKit

class MyChatCell: UITableViewCell {
    
    @IBOutlet weak var chatContent: UILabel!
    
    
    @IBOutlet weak var ChatView: UIView!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    public weak var delegate: HotelBookingCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        
        // Initialization code

        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(MyChatCell.tapped(_:)))
        
        tapGesture.delegate = self
        
        self.ChatView.addGestureRecognizer(tapGesture)
        
    }
    
    
    //https://i-app-tec.com/ios/uigesturerecognizer.html
    @objc func tapped(_ sender: UITapGestureRecognizer){
        if sender.state == .ended {
            print("タップ")
            delegate?.bookingCellBookButtonTouched()
        }
    }
    
    func followTrip(sender:UITapGestureRecognizer) {
        print("tap working")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
}


protocol HotelBookingCellDelegate: class {
    func bookingCellBookButtonTouched()
}
