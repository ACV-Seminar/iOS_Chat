//
//  User.swift
//  SoftBankChat
//
//  Created by ChuoiChien on 3/21/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class User: NSObject, NSCoding {
    var id: Int?
    var nickname: String?
    var isConnected: Bool?
    
    required convenience init?(coder aDecoder: NSCoder) {
        self.init()
        if let id = aDecoder.decodeObject(forKey: "id") as? Int {
            self.id = id
        }
        if let nickname = aDecoder.decodeObject(forKey: "nickname") as? String {
            self.nickname = nickname
        }
        if let isConnected = aDecoder.decodeObject(forKey: "isConnected") as? Bool {
            self.isConnected = isConnected
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "id")
        aCoder.encode(self.nickname, forKey: "nickname")
        aCoder.encode(self.isConnected, forKey: "isConnected")
    }
    
    func getDataFromDic(_ dic: [String: Any]) {
        id = dic["id"] as? Int
        nickname = dic["nickname"] as? String
        isConnected = dic["isConnected"] as? Bool
    }
}
