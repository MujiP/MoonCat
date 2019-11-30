//
//  ViewController.swift
//  MoonCat
//
//  Created by Si Yu Zhuang on 11/28/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//
import UIKit

class EventCreationPage_VC: UIViewController, UITextViewDelegate{
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let topDecorator = UIView()
    let topControl = UIStackView()
    let bodyContainer = UIStackView()
    let topNavigation = UINavigationBar()
    var textField = UITextView()
    
    func setupTopNavigation(){
//        topNavigation.barStyle = .blackTranslucent
        let navItem = UINavigationItem(title: "")
        let create = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: nil)
        navItem.rightBarButtonItem = create
        navItem.leftBarButtonItem = cancel
        topNavigation.setItems([navItem], animated: false)
        view.addSubview(topNavigation)
        topNavigation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topNavigation.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            topNavigation.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            topNavigation.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            topNavigation.heightAnchor.constraint(equalToConstant: view.frame.height/18)
        ])
    }
    
    // MARK: - TopControl
    func setupTopControl() {
        
        // TODO: Add actual control
        // TODO: Make button icons in grafitti style
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)

        let createButton = UIButton(type: .custom)
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.systemGray, for: .disabled)
        createButton.setTitleColor(.systemBlue, for: .normal)

        
        // reserved
        let topTitle = UILabel()
        topTitle.numberOfLines = 0
        topTitle.textAlignment = .center
        topTitle.text = " "
        topTitle.textColor = UIColor.black
        topTitle.adjustsFontSizeToFitWidth = false
        topTitle.font = .boldSystemFont(ofSize: 20)
        
        topControl.addArrangedSubview(cancelButton)
        topControl.addArrangedSubview(topTitle)
        topControl.addArrangedSubview(createButton)

//        topControl.layoutMargins = UIEdgeInsets(top: 2, left: 20, bottom: 2, right: 20)
//        topControl.isLayoutMarginsRelativeArrangement = true
        topControl.axis = .horizontal
        topControl.distribution = .fillEqually
        view.addSubview(topControl)
        topControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topControl.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            topControl.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            topControl.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            topControl.heightAnchor.constraint(equalToConstant: view.frame.height/18)
        ])
    }
    
    func setupTopDecor(color: UIColor){
        topDecorator.backgroundColor = color
        topDecorator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topDecorator)
        NSLayoutConstraint.activate([topDecorator.leadingAnchor.constraint(equalTo:view.leadingAnchor),
        topDecorator.trailingAnchor.constraint(equalTo:view.trailingAnchor),
        topDecorator.heightAnchor.constraint(equalToConstant: view.frame.height/9)])
    }
    
    // MARK: - PageBody
    
    // Holding content with stackview for easy auto layout
    func setupBodyContainer() {
        bodyContainer.axis = .vertical
        bodyContainer.layoutMargins = UIEdgeInsets(top: 2, left: 10, bottom: 2, right: 10)
        bodyContainer.isLayoutMarginsRelativeArrangement = true
        bodyContainer.distribution = .fillEqually
        bodyContainer.spacing = .ulpOfOne
        view.addSubview(bodyContainer)
        bodyContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bodyContainer.topAnchor.constraint(equalTo:topControl.bottomAnchor),
            bodyContainer.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            bodyContainer.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            bodyContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // Add views into page body from top down
    func addToBodyContainer(views: Array<UIView>){
        for view in views{
            bodyContainer.addArrangedSubview(view)
        }
    }
    
    // Set up the page title View
    func setUpTitle() {
        // style
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.textColor = UIColor.black
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.font = .monospacedDigitSystemFont(ofSize: 30, weight: .heavy)
    }
    
    // Set up the page subtitle view (e.g, for further user instructions
    func setupSubTitle(){
        // style
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor.gray
        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.font = subtitleLabel.font.withSize(18)
    }
    
    // MARK: - DataEntry
    // Set up text filed view for user input
    func setupTextField(){
        // style
        textField.textColor = UIColor.lightGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "verdana", size: 14.0)
        // close keyboard if user clicks done
        textField.returnKeyType = .done
        textField.delegate = self
        
    }
    
    // set text view delegates to allow a placeholder to prompt user for text
    //MARK: - UITextViewDelegates
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textField.text == "Let others know what your event is about..."{
            textField.text = ""
            textField.textColor = UIColor.black
            textField.font = UIFont(name: "verdana", size: 14.0)
        }
        
    }
    // if user types nothing or deletes everything, show placeholder(prompt) again
    func textViewDidEndEditing(_ textView: UITextView) {
        if textField.text == ""{
            textField.text = "Let others know what your event is about..."
            textField.textColor = UIColor.lightGray
            textField.font = UIFont(name: "verdana", size: 14.0)
        }
    }
    // if user is done typing close the keyboard
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textField.resignFirstResponder()
        }
        
        return true
    }


}


    


    
    




