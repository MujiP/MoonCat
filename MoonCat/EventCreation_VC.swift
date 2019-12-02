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
    var eventDB = eventDatabase()
    
    override init(){
        super.init()
        setPages()
    }
    
    // MARK: - load pages as UIViews here
    private func setPages() -> Void{
        let page1 = live(eventDB: eventDB)
        let page2 = live2(eventDB: eventDB)
        let page3 = live3(eventDB: eventDB)
        let page4 = live4(eventDB: eventDB)
        let page5 = live5(eventDB: eventDB)
        let page6 = DescEntryPage(eventDB: eventDB)
        let page7 = TimeSelectPage(eventDB: eventDB)
        let page8 = LocationEntryPage(eventDB: eventDB)
        let page9 = TagEntryPage(eventDB: eventDB)
        let page10 = MemberRestrainPage(eventDB: eventDB)
        self.pages.append(contentsOf: [page1, page2, page3, page4, page5, page6, page7, page8, page9, page10])
    }
    
    
    func getPages() -> Array<UIViewController> {
        return pages
    }
    
    func getFirstPage() -> UIViewController {
        return pages[0]
    }
    
    // Return previous UIVC when swipe left
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
        if let currentPageIndex = self.pages.firstIndex(of: viewController) {
            if currentPageIndex == 0 {
                return nil
            } else {
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


// Dedicate class for storing data from page view dynamically
class eventDatabase{
    var eventDesc = String()
    var startDateTime = String()
    var location = String()
    var area = String()
    var maxPeople = String()
    var tags = [String]()
    var date: Date!

    func dataSanityCheckPassed() -> Bool {

        print(eventDesc)
        print(startDateTime)
        print(location)
        print(area)
        print(maxPeople)
        print(tags)
        return (!eventDesc.isEmpty && !startDateTime.isEmpty && !location.isEmpty && !area.isEmpty)
    }
    
    func reloadData(){
        eventDesc = ""
        startDateTime = ""
        location = ""
        maxPeople = ""
        tags.removeAll()
    }
}
