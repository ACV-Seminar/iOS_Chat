//
//  Constant.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/13/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

let NEW_INDEX_INTRO = "newIndex"
let UPDATE_INDEX = "UpdateIndex"

let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad

let WIDTH_DEVICE = UIScreen.main.bounds.size.width
let HEIGHT_DEVICE = UIScreen.main.bounds.size.height

let IS_IPHONE_X = max(WIDTH_DEVICE, HEIGHT_DEVICE) == 812 && IS_IPHONE
let IS_IPHONE_4 = max(WIDTH_DEVICE, HEIGHT_DEVICE) < 568 && IS_IPHONE
let IS_IPHONE_5 = max(WIDTH_DEVICE, HEIGHT_DEVICE) == 568 && IS_IPHONE
let IS_IPHONE_6 = max(WIDTH_DEVICE, HEIGHT_DEVICE) == 667 && IS_IPHONE
let IS_IPHONE_6_PLUS = max(WIDTH_DEVICE, HEIGHT_DEVICE) == 736 && IS_IPHONE

enum INDEX_INTRO_CURRENT: Int {
    case page1
    case page2
    case page3
    case page4
    case page5
}

enum CodeType: Int {
    case Success = 200
    case Unauthorized = 401
    case NoInternet = -1009
    case TimeOut =   -1001
    case CanNotConnectToServer = -1004
    
    
    static func isCodeNoInternetOrTimeOut(code:Int) -> Bool{
        switch code {
        case CodeType.NoInternet.rawValue:
            return true
        case CodeType.TimeOut.rawValue:
            return true
        case CodeType.CanNotConnectToServer.rawValue:
            return true
        default: break
            
            
        }
        
        return false
    }
}

struct ERROR_MESSAGE{
    static let ERROR_NO_INTERNET = "データを取得することができませんでした。\nしばらくしてから、再度お試しください。"
}


