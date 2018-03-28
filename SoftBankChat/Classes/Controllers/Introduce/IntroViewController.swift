//
//  IntroViewController.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/13/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

class IntroViewController: BaseViewController {

    var pageViewController: IntroPageViewController? {
        didSet {
            pageViewController?.isCyclePage = false
            pageViewController?.pageDelegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageControl.numberOfPages = (pageViewController?.orderedViewControllers.count) ?? 0
        pageControl.currentPage = pageViewController?.currentIndex ?? 0
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.isUserInteractionEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageVC = segue.destination as? IntroPageViewController {
            self.pageViewController = pageVC
        }
    }
}

extension IntroViewController: PageViewControllerDelegate {
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageCount count: Int) {
        print("page count \(count)")
    }
    
    func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int) {
        print("page index \(index)")
        pageControl.currentPage = index
    }
}
