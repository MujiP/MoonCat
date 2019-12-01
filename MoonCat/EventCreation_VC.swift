//
//  EventCreation_VC.swift
//  MoonCat
//
//  Created by Kirk Lu on 11/28/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class EventCreation_VC: UIPageViewController, UIPageViewControllerDelegate{
    var pageViews = PageDataSource()
    let pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = pageViews
        
        // Display pages
        setViewControllers([self.pageViews.getFirstPage()], direction: .forward, animated: true, completion: nil)
        // setupPageControl()
    }
    
    // set up bottom dots as page indicator
    func setupPageControl(){
        //TODO: customization
    }

}


// Handling pages source and swipe transition
class PageDataSource: NSObject, UIPageViewControllerDataSource {
    var pages = [UIViewController]()
    var currentIndex: Int = 0
    
    override init(){
        super.init()
        setPages()
    }
    
    // MARK: - load pages as UIViews here
    private func setPages() -> Void{
        //
        let page1 = live()
        let page2 = live2()
        let page3 = DescEntryPage()
        let page4 = TimeSelectPage()
        self.pages.append(contentsOf: [page1, page2, page3, page4])
    }
    
    
    func getPages() -> Array<UIViewController> {
        return pages
    }
    
    func getFirstPage() -> UIViewController {
        return pages[0]
    }
    
    // Return previous UIVC when swipe left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        // error handling
        if let currentPageIndex = self.pages.firstIndex(of: viewController) {
            if currentPageIndex == 0 {
                // Stay
                // TODO: check here
                return nil
            } else {
                // Update new page index
                // TODO: check here
                self.currentIndex = currentPageIndex - 1
                assert(self.currentIndex >= 0 && self.currentIndex < self.pages.count, "Index out of bound when swipe right with " + String(self.currentIndex))
                return self.pages[currentPageIndex - 1]
            }
        }
        return nil
    }
    
    // Return next UIVC when swipe right
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
        if let currentPageIndex = self.pages.firstIndex(of: viewController) {
            if currentPageIndex < self.pages.count - 1 {
                // Update index
                self.currentIndex = currentPageIndex + 1
                assert(self.currentIndex >= 0 && self.currentIndex < self.pages.count, "Index out of bound when swipe right with " + String(self.currentIndex))
                return self.pages[currentPageIndex + 1]
            } else {
                // Stay
                return nil
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
}
