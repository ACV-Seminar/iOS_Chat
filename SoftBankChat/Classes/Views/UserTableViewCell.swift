//
//  UserTableViewCell.swift
//  SoftBankChat
//
//  Created by ChuoiChien on 3/21/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var avartar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configUI(_ user: User?) -> Void {
        avartar.image = (user?.isConnected)! ? UIImage(named: "useronline") : UIImage(named: "useroff")
        name.text = user?.nickname
        detail.text = (user?.isConnected)! ? "Online" : "Offline"
        detail.textColor = (user?.isConnected)! ? UIColor.green : UIColor.red
    }
}
