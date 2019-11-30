//
//  ViewController.swift
//  MoonCat
//
//  Created by Si Yu Zhuang on 11/28/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

class EventCreationPages_VC: UIViewController, UITextViewDelegate{
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
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

}


