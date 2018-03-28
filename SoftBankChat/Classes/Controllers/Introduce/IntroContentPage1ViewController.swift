//
//  IntroContentPage1ViewController.swift
//  FleaMarket
//
//  Created by NguyenVanChien on 12/7/17.
//  Copyright © 2017 atmarkcafe. All rights reserved.
//

import UIKit

class IntroContentPage1ViewController: BaseViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        statusBar?.backgroundColor = UIColor.clear
    }
    
    @IBAction func gotoScreenIntro2(_ sender: Any) {
        let dict = [NEW_INDEX_INTRO: INDEX_INTRO_CURRENT.page2.rawValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UPDATE_INDEX), object: nil, userInfo: dict)
    }
}
