//
//  IntroContentPage2ViewController.swift
//  FleaMarket
//
//  Created by NguyenVanChien on 12/8/17.
//  Copyright © 2017 atmarkcafe. All rights reserved.
//

import UIKit

class IntroContentPage2ViewController: BaseViewController {

    @IBOutlet weak var buttonDone: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoScreenIntro3(_ sender: Any) {
        let dict = [NEW_INDEX_INTRO: INDEX_INTRO_CURRENT.page3.rawValue]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: UPDATE_INDEX), object: nil, userInfo: dict)
    }
}
