//
//  A_VC.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-12.
//  Copyright © 2019 Bolusaur. All rights reserved.
//
import UIKit

// Description
class A_VC: EventCreationPage_VC {
    let pageTitle:String = "Tell people more about your awesome event!"
    let placeholder:String = "Say..."

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()
        //setupTopNavigation()
        setUpTitle(title: pageTitle)
        setupTextField(defaultText: placeholder, color: UIColor.init(white: 0.95, alpha: 0.5))
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.textField])
        print("live")
    }
    
 

}

// Tags
class A_VC1: EventCreationPage_VC {
    let pageTitle:String = "Event Description"
    let placeholder:String = "Let others know what your event is about..."

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupTopDecor(color: UIColor.groupTableViewBackground)
        setupTopControl()
        //setupTopNavigation()
        setUpTitle(title: pageTitle)
        setupTextField(defaultText: placeholder, color:UIColor.white)
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.textField])
        print("Minimal")
    }

}

// Time
class A_VC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemGreen
        
        print("Hello from A_VC")
    }

}

// Number of people
class A_VC3: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemTeal
        
        print("Hello from A_VC")
    }

}

