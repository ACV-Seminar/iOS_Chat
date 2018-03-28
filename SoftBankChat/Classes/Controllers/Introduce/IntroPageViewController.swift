//
//  IntroPageViewController.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/13/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class IntroPageViewController: BasePageViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateCurrentIndex(_:)), name: NSNotification.Name(rawValue: UPDATE_INDEX), object: nil)
        let page1VC = IntroContentPage1ViewController()
        let page2VC = IntroContentPage2ViewController()
        let page3VC = IntroContentPage3ViewController()
        let page4VC = IntroContentPage4ViewController()
        let page5VC = IntroContentPage5ViewController()
        orderedViewControllers = [page1VC, page2VC, page3VC, page4VC, page5VC]
        
        if let initialViewController = orderedViewControllers.first {
            self.scrollToViewController(viewController: initialViewController)
        }
        
        pageDelegate?.pageViewController!(pageViewController: self, didUpdatePageCount: orderedViewControllers.count)
        for view in self.view.subviews {
            if let scroll = view as? UIScrollView {
                scroll.delegate = self
            }
        }
    }

    @objc func updateCurrentIndex(_ notification: NSNotification) -> Void {
        let dictionary = notification.userInfo
        if let index = dictionary![NEW_INDEX_INTRO]  {
            self.scrollToViewController(index: index as! Int)
        }
    }
}

extension IntroPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if currentIndex == orderedViewControllers.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if currentIndex == 0 && scrollView.contentOffset.x < scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        } else if currentIndex == orderedViewControllers.count - 1 && scrollView.contentOffset.x > scrollView.bounds.size.width {
            scrollView.contentOffset = CGPoint(x: scrollView.bounds.size.width, y: 0)
        }
    }
}
