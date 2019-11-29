//
//  EventCreation_VC.swift
//  MoonCat
//
//  Created by Kirk Lu on 11/28/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class EventCreation_VC: UIPageViewController, UIPageViewControllerDelegate{
    var pageViews = PagesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = pageViews
    }
    
    // set up bottom dots as page indicator
    func setupBottomControl(){
        
    }

}


class PagesDataSource: NSObject, UIPageViewControllerDataSource{
    var pages = [UIViewController]()
    
    // load pages as UIViews
    func loadPages(){
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        // error handling
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex == 0 {
                // stay
                // TODO: check here
                return nil
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
            
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
        if let viewControllerIndex = self.pages.firstIndex(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // stay
                return nil
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    // unfinished
    // error handling
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return self.pages.firstIndex(of: pageViewController)
    }
}
