//
//  A_VC.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-12.
//  Copyright © 2019 Bolusaur. All rights reserved.
//
import UIKit

// Description
class A_VC: UIViewController, UITextViewDelegate {
    var titleLabel = UILabel()
    var textField = UITextView()
     let placeholder = "Let others know what your event is about..."
    let pageTitle = "Event Description"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        setupTextField()
        setUpTitle()
        print("Hello from A_VC")
    }
    
    func setUpTitle() {
       titleLabel.numberOfLines = 0
       titleLabel.textAlignment = .center
        titleLabel.text = pageTitle
       titleLabel.textColor = UIColor.black
       titleLabel.adjustsFontSizeToFitWidth = false
       titleLabel.font = titleLabel.font.withSize(20)
       titleLabel.translatesAutoresizingMaskIntoConstraints = false
       self.view.addSubview(titleLabel)
       NSLayoutConstraint.activate([
           titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 130.0),
           titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
           titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
       ])
    }
    
    func setupTextField(){
        textField.text = placeholder
        textField.textColor = UIColor.lightGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "verdana", size: 14.0)
        textField.returnKeyType = .done
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(textField)
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 200.0),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            textField.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16.0)
        ])
        
    }
    
    //MARK: - UITextViewDelegates
    func textViewDidBeginEditing(_ textView: UITextView) {
           if textField.text == placeholder{
               textField.text = ""
               textField.textColor = UIColor.black
               textField.font = UIFont(name: "verdana", size: 14.0)
           }
           
       }
       
    func textViewDidEndEditing(_ textView: UITextView) {
           if textField.text == ""{
               textField.text = placeholder
               textField.textColor = UIColor.lightGray
               textField.font = UIFont(name: "verdana", size: 14.0)
           }
       }
       
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if text == "\n"{
               textField.resignFirstResponder()
           }
           
           return true
       }

}

// Tags
class A_VC1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.systemYellow
        
        print("Hello from A_VC")
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

