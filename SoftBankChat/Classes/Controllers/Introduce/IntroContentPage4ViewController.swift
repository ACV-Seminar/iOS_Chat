//
//  IntroContentPage4ViewController.swift
//  FleaMarket
//
//  Created by NinhNM_ACV on 12/4/17.
//  Copyright © 2017 atmarkcafe. All rights reserved.
//

import UIKit

class IntroContentPage4ViewController: BaseViewController {

    @IBOutlet weak var btnNext: UIButton!
    var position = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func invokePage5(_ sender: Any) {
        let dict = [NEW_INDEX_INTRO: INDEX_INTRO_CURRENT.page5.rawValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UPDATE_INDEX), object: nil, userInfo: dict)
    }
    
}
