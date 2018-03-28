//
//  ChatRoomViewController.swift
//  SoftBankChat
//
//  Created by ChuoiChien on 3/24/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class ChatRoomViewController: BaseViewController {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var tvMessageEdit: UITextView!
    @IBOutlet weak var lbOtherUserTyping: UILabel!
    @IBOutlet weak var lbOtherUserStatus: UILabel!
    @IBOutlet weak var contraintBottomSendChat: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var nickname: String?
    var chatMessages = [Chat]()
    var bannerLabelTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = nickname
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatRoomViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatRoomViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserInRoomChatNotification), name: NSNotification.Name(rawValue: "userInRoomChatNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserOutRoomChatNotification), name: NSNotification.Name(rawValue: "userOutRoomChatNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleLogoutUserNotification), name: NSNotification.Name(rawValue: "userWasLogoutNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserTypingNotification), name: NSNotification.Name(rawValue: "userTypingNotification"), object: nil)
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ChatRoomViewController.dismissKeyboard)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTableView()
        configureNewsBannerLabel()
        configureOtherUserActivityLabel()
        
        tvMessageEdit.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            DispatchQueue.main.async {
                let chat = Chat()
                chat.getDataFromDic(messageInfo)
                self.chatMessages.append(chat)
                self.tableView.reloadData()
                self.tableView.tableViewScrollToBottom(animated: true)
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func invokedBack(_ sender: Any) {
        guard nickname != nil && nickname != "" else {
            return
        }
        SocketIOManager.sharedInstance.outRoomChatWithNickname(nickname: nickname!) { () -> Void in
            
        }
    }
    
    @IBAction func invokedSendMessage(_ sender: Any) {
        if tvMessageEdit.text != nil && tvMessageEdit.text != "" {
            SocketIOManager.sharedInstance.sendMessage(message: tvMessageEdit.text!, withNickname: nickname!)
            tvMessageEdit.text = ""
            tvMessageEdit.resignFirstResponder()
        }
    }
}

extension ChatRoomViewController {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        tableView.estimatedRowHeight = 90.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func configureOtherUserActivityLabel() {
        lbOtherUserTyping.isHidden = true
        lbOtherUserTyping.text = ""
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.view.frame.origin.y = 0
            self.contraintBottomSendChat.constant = IS_IPHONE_X ? keyboardSize.height - 34 : keyboardSize.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        self.contraintBottomSendChat.constant = 0
    }
    
    func configureNewsBannerLabel() {
        lbOtherUserStatus.layer.cornerRadius = 15.0
        lbOtherUserStatus.clipsToBounds = true
        lbOtherUserStatus.alpha = 0.0
    }
    
    func showBannerLabelAnimated() {
        UIView.animate(withDuration: 0.75, animations: { () -> Void in
            self.lbOtherUserStatus.alpha = 1.0
            
        }) { (finished) -> Void in
            self.bannerLabelTimer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ChatRoomViewController.hideBannerLabel), userInfo: nil, repeats: false)
        }
    }
    
    @objc func hideBannerLabel() {
        if bannerLabelTimer != nil {
            bannerLabelTimer.invalidate()
            bannerLabelTimer = nil
        }
        
        UIView.animate(withDuration: 0.75, animations: { () -> Void in
            self.lbOtherUserStatus.alpha = 0.0
            
        }) { (finished) -> Void in
        }
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
        SocketIOManager.sharedInstance.sendStopTypingMessage(nickname: nickname!)
    }
    
    @objc func handleUserInRoomChatNotification(notification: NSNotification) {
        let userJoinInfo = notification.object as! String
        lbOtherUserStatus.text = "User \(userJoinInfo.uppercased()) was just joined zoom."
        showBannerLabelAnimated()
    }
    
    @objc func handleUserOutRoomChatNotification(notification: NSNotification) {
        let userOutNickname = notification.object as! String
        lbOtherUserStatus.text = "User \(userOutNickname.uppercased()) has just left room."
        showBannerLabelAnimated()
    }
    
    @objc func handleLogoutUserNotification(notification: NSNotification) {
        let logoutUserNickname = notification.object as! String
        lbOtherUserStatus.text = "User \(logoutUserNickname.uppercased()) has logout."
        showBannerLabelAnimated()
    }
    
    @objc func handleUserTypingNotification(notification: NSNotification) {
        if let typingUsersDictionary = notification.object as? [String: AnyObject] {
            var names = ""
            var totalTypingUsers = 0
            for (typingUser, _) in typingUsersDictionary {
                if typingUser != nickname {
                    names = (names == "") ? typingUser : "\(names), \(typingUser)"
                    totalTypingUsers += 1
                }
            }
            
            if totalTypingUsers > 0 {
                let verb = (totalTypingUsers == 1) ? "is" : "are"
                
                lbOtherUserTyping.text = "\(names) \(verb) now typing a message..."
                lbOtherUserTyping.isHidden = false
            }
            else {
                lbOtherUserTyping.isHidden = true
            }
        }
    }
}

extension ChatRoomViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell", for: indexPath as IndexPath) as! ChatTableViewCell
        let chat = chatMessages[indexPath.row]
        cell.configUI(chat: chat, nickname: nickname)
        return cell
    }
    
}

extension ChatRoomViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        SocketIOManager.sharedInstance.sendStartTypingMessage(nickname: nickname!)
        return true
    }
}

extension UITableView {
    
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.async {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                self.scrollToRow(at: indexPath, at: UITableViewScrollPosition.bottom, animated: animated)
            }
        }
    }
}
