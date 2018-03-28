//
//  LoginViewController.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/15/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    static func create()-> LoginViewController{
        return UIUtils.viewControllerWithIndentifier(identifier: "LoginViewController", storyboardName: "Authen") as! LoginViewController
    }
    
    @IBOutlet weak var nickNameTextField: UITextField!
    var nickname: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func invokedLogin(_ sender: Any) {
        self.nickname = nickNameTextField.text
        
        if Validate.validateNickname(self.nickname).0 {
            let listUserVC = UIUtils.viewControllerWithIndentifier(identifier: "ListUserViewController", storyboardName: "Authen") as! ListUserViewController
            listUserVC.nickname = nickname
            self.navigationController?.pushViewController(listUserVC, animated: true)
        }
    }
}
