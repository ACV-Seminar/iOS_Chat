//
//  TransitionsUtils.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/22/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class DismissSegue : UIStoryboardSegue {
    override func perform() {
        source.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

class PopSegue : UIStoryboardSegue {
    override func perform() {
        source.navigationController?.popViewController(animated: true)
    }
}

class PopFadeAnimSegue : UIStoryboardSegue {
    override func perform() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        source.navigationController?.view.layer.add(transition, forKey: nil)
        
        source.navigationController?.popViewController(animated: false)
    }
}

class PopToRootFadeAnimSegue : UIStoryboardSegue {
    override func perform() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        source.navigationController?.view.layer.add(transition, forKey: nil)
        
        source.navigationController?.popToRootViewController(animated: false)
    }
}

class PushFadeAnimSegue : UIStoryboardSegue {
    override func perform() {
        let transition = CATransition()
        transition.duration = 0.35
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        source.navigationController?.view.layer.add(transition, forKey: nil)
        
        source.navigationController?.pushViewController(destination, animated: false)
    }
}
