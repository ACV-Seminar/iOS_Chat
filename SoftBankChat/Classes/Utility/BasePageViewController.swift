//
//  BasePageViewController.swift
//  SoftBankChat
//
//  Created by NguyenVanChien on 3/13/18.
//  Copyright © 2018 NguyenVanChien. All rights reserved.
//

import UIKit

@objc protocol PageViewControllerDelegate: class {
    
    @objc optional func pageViewController(pageViewController: UIPageViewController, didUpdatePageCount count: Int)
    
    @objc optional func pageViewController(pageViewController: UIPageViewController, didUpdatePageIndex index: Int)
}

class BasePageViewController: UIPageViewController {

    weak var pageDelegate: PageViewControllerDelegate?
    var isCyclePage: Bool = true
    var currentIndex: Int?
    var orderedViewControllers: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func orderedViewControllers(viewControllersName: [String], storyboardName: String) -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        for name in viewControllersName {
            let viewController = UIUtils.viewControllerWithIndentifier(identifier: name, storyboardName: storyboardName)
            viewControllers.append(viewController)
        }
        return viewControllers
    }
}

extension BasePageViewController {
    
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController) {
            self.scrollToViewController(viewController: nextViewController)
        }
    }
    
    func scrollToPreviousViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self, viewControllerBefore: visibleViewController) {
            let direction: UIPageViewControllerNavigationDirection = .reverse
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(viewController: nextViewController, direction: direction)
        }
    }
    
    func scrollToViewController(viewController: UIViewController, direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (finished) -> Void in
                            self.notifyPageDelegateOfNewIndex()
        })
    }
    
    func notifyPageDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            currentIndex = index
            pageDelegate?.pageViewController!(pageViewController: self, didUpdatePageIndex: index)
        }
    }
}

// MARK: UIPageViewController
extension BasePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            if self.isCyclePage == true {
                return orderedViewControllers.last
            }
            
            return nil
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            if self.isCyclePage == true {
                return orderedViewControllers.first
            }
            
            return nil
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
    
}

extension BasePageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        notifyPageDelegateOfNewIndex()
    }
}
