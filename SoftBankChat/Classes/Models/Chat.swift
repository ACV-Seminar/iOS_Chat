//
//  Chat.swift
//  SoftBankChat
//
//  Created by ChuoiChien on 3/25/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class Chat: NSObject, NSCoding {
    var nickname: String?
    var message: String?
    var date: String?
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
      
        if let nickname = aDecoder.decodeObject(forKey: "nickname") as? String {
            self.nickname = nickname
        }
        if let message = aDecoder.decodeObject(forKey: "message") as? String {
            self.message = message
        }
        if let date = aDecoder.decodeObject(forKey: "date") as? String {
            self.date = date
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.nickname, forKey: "nickname")
        aCoder.encode(self.date, forKey: "date")
        aCoder.encode(self.message, forKey: "message")
    }
    
    func getDataFromDic(_ dic: [String: Any]) {
        nickname = dic["nickname"] as? String
        date = dic["date"] as? String
        message = dic["message"] as? String
    }
}
