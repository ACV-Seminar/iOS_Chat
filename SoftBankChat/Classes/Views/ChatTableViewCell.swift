//
//  ChatTableViewCell.swift
//  SoftBankChat
//
//  Created by ChuoiChien on 3/25/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var lbChatContent: UILabel!
    @IBOutlet weak var lbMessageDetail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI(chat: Chat, nickname: String?) -> Void {
        if chat.nickname == nickname {
            lbChatContent.textAlignment = NSTextAlignment.right
            lbMessageDetail.textAlignment = NSTextAlignment.right
        }
        
        lbChatContent.text = chat.message
        lbMessageDetail.text = "by " + chat.nickname! + " @ " + chat.date!
    }
}
