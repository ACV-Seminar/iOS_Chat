//
//  IntroContentPage3ViewController.swift
//  FleaMarket
//
//  Created by NinhNM_ACV on 12/4/17.
//  Copyright © 2017 atmarkcafe. All rights reserved.
//

import UIKit

class IntroContentPage3ViewController: BaseViewController {
    var position = 0
    @IBOutlet weak var btnNext: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func invokePage4(_ sender: Any) {
        let dict = [NEW_INDEX_INTRO: INDEX_INTRO_CURRENT.page4.rawValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UPDATE_INDEX), object: nil, userInfo: dict)
    }
}
