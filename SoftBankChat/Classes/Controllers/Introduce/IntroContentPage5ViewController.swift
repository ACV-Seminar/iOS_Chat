//
//  IntroContentPage5ViewController.swift
//  FleaMarket
//
//  Created by KHUONG_ACV on 12/4/17.
//  Copyright © 2017 atmarkcafe. All rights reserved.
//

import UIKit

class IntroContentPage5ViewController: BaseViewController {

    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneAction(_ sender: Any) {
       // Goto Login
        let nav = UINavigationController(rootViewController: LoginViewController.create())
        nav.isNavigationBarHidden = true
        AppDelegate.shareInstance.setRootViewController(nav)
    }
}
