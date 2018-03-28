//
//  Validate.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/15/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

let NAME_CHARACTER_LIMIT = 40

class Validate: NSObject {
    class func validateNickname(_ nickname: String?) -> (Bool, String) {
        guard let name = nickname, name != "" else {
            return (false, "ニックネームを入力してください。")
        }
        if name.characters.count > NAME_CHARACTER_LIMIT {
            return (false, "ニックネームが最大文字数40文字を超えています。")
        }
        return (true, "OK")
    }
}
