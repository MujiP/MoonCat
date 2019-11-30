//
//  ViewController.swift
//  MoonCat
//
//  Created by Si Yu Zhuang on 11/28/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//
import UIKit

class EventCreationPages_VC: UIViewController, UITextViewDelegate{
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let topDecorator = UIView()
    let topControl = UIStackView()
    var textField = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
    }
    
    // function for setting up the main title of the page
    func setUpTitle() {
       titleLabel.numberOfLines = 0
       titleLabel.textAlignment = .center
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
    
    // function for adding a subtitle below main title (e.g, for further user instructions
    func setupSubTitle(){
        subtitleLabel.numberOfLines = 0
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = UIColor.gray
        subtitleLabel.adjustsFontSizeToFitWidth = false
        subtitleLabel.font = subtitleLabel.font.withSize(18)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 160.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
        ])
    }
    
    // MARK: - DataEntry
    // function to set up a text view that allows user to type multiple lines of text
    func setupTextField(){
        //textField.text = "Let others know what your event is about..."
        textField.textColor = UIColor.lightGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "verdana", size: 14.0)
        // close keyboard if user clicks done
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

    /*
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - TopControl
    func setupTopControl() {
        
        
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        
        
        let createButton = UIButton(type: .system)
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
        topControl.addArrangedSubview(createButton)
        topControl.addArrangedSubview(topTitle)
        
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
    
    func setupTopDecor(){
        topDecorator.backgroundColor = .groupTableViewBackground
        topDecorator.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topDecorator)
        NSLayoutConstraint.activate([topDecorator.leadingAnchor.constraint(equalTo:view.leadingAnchor),
        topDecorator.trailingAnchor.constraint(equalTo:view.trailingAnchor),
        topDecorator.heightAnchor.constraint(equalToConstant: view.frame.height/9)])
    }
}


    


    
    




