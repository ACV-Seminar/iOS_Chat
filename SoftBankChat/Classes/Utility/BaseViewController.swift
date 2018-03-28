//
//  BaseViewController.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/13/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseViewController {
    func initUI() {
        let tapRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(hiddenKeyboard(_:)))
        tapRecognizer.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    // dissmiss keyboard when tap outside textfield
    @objc func hiddenKeyboard(_ sender: UITapGestureRecognizer) -> Void {
        self.view.endEditing(true)
    }
}
