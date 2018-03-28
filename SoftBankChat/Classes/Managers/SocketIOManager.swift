//
//  SocketIOManager.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/15/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let sharedInstance = SocketIOManager()
    let socket = SocketIOClient(socketURL: NSURL(string: "http://192.168.1.16:1992")! as URL)
   
    override init() {
        super.init()
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func connectToServerWithNickname(nickname: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
        socket.emit("connectUser", nickname)
        
        socket.on("userList") { ( dataArray, ack) -> Void in
            completionHandler(dataArray[0] as? [[String: AnyObject]])
        }
        
        listenForOtherMessages()
    }
    
    func exitChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("exitUser", nickname)
        completionHandler()
    }
    
    func joinRoomChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("joinRoomChat", nickname)
        completionHandler()
    }
    
    func outRoomChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("outRoomChat", nickname)
        completionHandler()
    }
    
    func disconnectChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("disconnectChat", nickname)
        completionHandler()
    }
    
    func reconnectChatWithNickname(nickname: String, completionHandler: () -> Void) {
        socket.emit("reconnectChat", nickname)
        completionHandler()
    }
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", nickname, message)
    }
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String: AnyObject]) -> Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) -> Void in
            var messageDictionary = [String: AnyObject]()
            messageDictionary["nickname"] = dataArray[0] as! String as AnyObject
            messageDictionary["message"] = dataArray[1] as! String as AnyObject
            messageDictionary["date"] = dataArray[2] as! String as AnyObject
            
            completionHandler(messageDictionary)
        }
    }
    
    private func listenForOtherMessages() {
        socket.on("userInRoomChat") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userInRoomChatNotification"), object: dataArray[0] as! String)
        }
        
        socket.on("userOutRoomChat") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userOutRoomChatNotification"), object: dataArray[0] as! String)
        }
        
        socket.on("userLogout") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasLogoutNotification"), object: dataArray[0] as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) -> Void in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userTypingNotification"), object: dataArray[0] as? [String: AnyObject])
        }
    }
    
    
    func sendStartTypingMessage(nickname: String) {
        socket.emit("startType", nickname)
    }
    
    
    func sendStopTypingMessage(nickname: String) {
        socket.emit("stopType", nickname)
    }
}
