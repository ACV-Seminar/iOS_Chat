//
//  ListUserViewController.swift
//  SoftBankChat
//
//  Created by ChuoiChien on 3/21/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class ListUserViewController: BaseViewController {

    var users = [User]()
    var nickname: String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibFile()
        if nickname != nil && nickname != "" {
            getListUserAndLoginWithName(nickname: nickname)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(willResignActive), name: .UIApplicationWillResignActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didBecomeActive), name: .UIApplicationDidBecomeActive, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "idJoinChatRoom" {
                guard nickname != nil && nickname != "" else {
                    return
                }
                SocketIOManager.sharedInstance.joinRoomChatWithNickname(nickname: nickname!) { () -> Void in
                    
                }
                let chatViewController = segue.destination as! ChatRoomViewController
                chatViewController.nickname = nickname
            }
        }
    }
    
    @IBAction func invokedExit(_ sender: Any) {
        guard nickname != nil && nickname != "" else {
            return
        }
        SocketIOManager.sharedInstance.exitChatWithNickname(nickname: nickname!) { () -> Void in
            DispatchQueue.main.async {
                // Goto Login
                let nav = UINavigationController(rootViewController: LoginViewController.create())
                nav.isNavigationBarHidden = true
                AppDelegate.shareInstance.setRootViewController(nav)
            }
        }
    }
}

extension ListUserViewController {
    func registerNibFile() -> Void {
        tableView.register(UINib.init(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableView.separatorStyle = .none
    }
    
    func getListUserAndLoginWithName(nickname: String?) -> Void {
        SocketIOManager.sharedInstance.connectToServerWithNickname(nickname: nickname!, completionHandler: { (userList) -> Void in
            if userList != nil {
                // save user login in local
                let userLogin = User()
                userLogin.nickname = self.nickname
                UIUtils.storeObjectToUserDefault(userLogin as AnyObject, key: "UserLogin")
                
                self.users.removeAll()
                for dic in userList! {
                    let user = User()
                    user.getDataFromDic(dic)
                    self.users.append(user)
                }
                self.tableView.reloadData()
            }
        })
    }
    
    @objc func willResignActive(_ notification: Notification) {
        guard nickname != nil && nickname != "" else {
            return
        }
        SocketIOManager.sharedInstance.disconnectChatWithNickname(nickname: nickname!) { () -> Void in
            
        }
    }
    
    @objc func didBecomeActive(_ notification: Notification) {
        guard nickname != nil && nickname != "" else {
            return
        }
        SocketIOManager.sharedInstance.reconnectChatWithNickname(nickname: nickname!) { () -> Void in
            
        }
    }
}

extension ListUserViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let user = users[indexPath.row]
        cell.configUI(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
}
