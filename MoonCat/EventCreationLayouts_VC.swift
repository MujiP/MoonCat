//
//  EventCreationLayouts_VC.swift
//  MoonCat
//
//  Created by Kirk on 11/30/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

// MARK: - Designs
// live color
class live: EventCreationPage_VC {
    let pageTitle:String = "Tell people more about your awesome event!"
    let placeholder:String = "Say..."

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow
        
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()
        // setupTopNavigation()
        setUpTitle()
        setupTextField()
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.textField])
        print("live")
    }
    
    override func setUpTitle() {
        super.setUpTitle()
        self.titleLabel.text = pageTitle
    }
    
    override func setupTextField() {
        super.setupTextField()
        self.textField.text = placeholder
        self.textField.backgroundColor = .init(white: 0.95, alpha: 0.5)
    }
}

class minimal: EventCreationPage_VC {
    let pageTitle:String = "Event Description"
    let placeholder:String = "Let others know what your event is about..."

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setupTopDecor(color: UIColor.groupTableViewBackground)
        setupTopControl()
        //setupTopNavigation()
        setUpTitle()
        setupTextField()
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.textField])
        print("Minimal")
    }
    
    override func setUpTitle() {
        super.setUpTitle()
        self.titleLabel.text = pageTitle
    }
    
    override func setupTextField() {
        super.setupTextField()
        self.textField.text = placeholder
        self.textField.backgroundColor = .white
    }
}

// MARK: - description
class DescEntryPage: EventCreationPage_VC{

    let placeholder = "Let others know what your event is about..."
    let pageTitle = "Event Description"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()
        setupTextField()
        setUpTitle()
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.textField])
        print("Description")
    }
    
   override func setUpTitle() {
        super.setUpTitle()
        self.titleLabel.text = pageTitle
    }
    
   override func setupTextField(){
        super.setupTextField()
        self.textField.text = placeholder
    }
    
   override func textViewDidBeginEditing(_ textView: UITextView) {
           if textField.text == placeholder{
               textField.text = ""
               textField.textColor = UIColor.black
               textField.font = UIFont(name: "verdana", size: 14.0)
           }
           
       }
       
   override func textViewDidEndEditing(_ textView: UITextView) {
           if textField.text == ""{
               textField.text = placeholder
               textField.textColor = UIColor.lightGray
               textField.font = UIFont(name: "verdana", size: 14.0)
           }
       }
       
    override func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if text == "\n"{
               textField.resignFirstResponder()
           }
           
           return true
       }

}

// MARK: - Time Selection
class TimeSelectPage: EventCreationPage_VC, UITextFieldDelegate{
    let startDoneBar = UIToolbar()
    let pageTitle = "When is it happening?"
    let startDatePicker = UIDatePicker()
    let startDateText = UITextField()
    override func viewDidLoad() {
    super.viewDidLoad()
        // Top Navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()

        // Body Content
        setUpTitle()
        setUpStartTime()
        
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.startDateText])
        print("Time")
    }
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
     }
    
    func setUpStartTime(){
        startDateText.backgroundColor = .white
        startDateText.borderStyle = .roundedRect
        startDateText.layer.cornerRadius = 8.0
        startDateText.layer.masksToBounds = true
        startDateText.layer.borderWidth = 1.0
        startDateText.layer.borderColor = UIColor.lightGray.cgColor
        startDateText.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.datePickerMode  = .dateAndTime
        startDatePicker.backgroundColor = .white
        startDateText.inputView = startDatePicker
        createStartToolBar() // create the tool bar for date picker
        startDateText.inputAccessoryView = startDoneBar
//        self.view.addSubview(startDateText)
//        NSLayoutConstraint.activate([
//            startDateText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 265.0),
//            startDateText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 200.0),
//            startDateText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
//        ])
    }

    func createStartToolBar(){
        // set up tool bar
        startDoneBar.autoresizingMask = .flexibleHeight
        startDoneBar.barStyle = .default
        startDoneBar.barTintColor = .white
        startDoneBar.backgroundColor = .white
        startDoneBar.isTranslucent = false
        
        // add done button to toolbar
        let startDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(startButtonTap(_:)))
        startDoneButton.tintColor = .systemTeal
        startDoneBar.items = [startDoneButton]
    }
    
    @objc func startButtonTap(_ button: UIBarButtonItem){
        // close date picker
        startDateText.resignFirstResponder()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm"
        startDateText.text = format.string(from: startDatePicker.date)
    }
}

// MARK: - Max Number of people
class MemberRestrainPage: EventCreationPage_VC, UITextFieldDelegate{
    let maxNumLabel = UILabel()
    let maxNum = UITextField()
    let pageTitle = "Set a maximum number of people"
    let subtitle = "Choose the maximum number of people you want to attend your event. Once this number is reached your event will become private."
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Top Navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()

        // Body Content
        setUpTitle()
        setupSubTitle()
        setUpMaxNum()
        print("Member")
    }
     
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
     }
     
    
    override func setupSubTitle() {
        super.setupSubTitle()
        self.subtitleLabel.text = subtitle
    }
    
    func setUpMaxNum(){
        maxNumLabel.numberOfLines = 0
        maxNumLabel.textAlignment = .center
        maxNumLabel.text = "Max. Number Of People"
        maxNumLabel.textColor = .black
        maxNumLabel.font = maxNumLabel.font.withSize(20)
        maxNumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(maxNumLabel)
        NSLayoutConstraint.activate([
            maxNumLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 290.0),
            maxNumLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 90.0),
            maxNumLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -90.0)
        ])
        
        maxNum.backgroundColor = .white
        maxNum.borderStyle = .roundedRect
        maxNum.layer.cornerRadius = 8.0
        maxNum.layer.masksToBounds = true
        maxNum.layer.borderWidth = 1.0
        maxNum.layer.borderColor = UIColor.lightGray.cgColor
        maxNum.delegate = self
        maxNum.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(maxNum)
        NSLayoutConstraint.activate([
            maxNum.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 350.0),
            maxNum.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 130.0),
            maxNum.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -130.0)
        ])
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            self.view.endEditing(true)
            return true
        }
    }
    

// MARK: - Tag Entry
class tagEntryPage: EventCreationPage_VC, UIPickerViewDelegate, UIPickerViewDataSource{
    let pageTitle = "Add tags to your event!"
    let subtitle = "Select up to three tags for your event. You should add at least one"
    let catArray = ["Coffee", "Food", "Study", "Other"]
    var catPicker = UIPickerView()
    let doneButton1 = UIButton()
    let doneButton2 = UIButton()
    let doneButton3 = UIButton()
    let tag1 = UILabel()
    let tag2 = UILabel()
    let tag3 = UILabel()
    let tagButton1 = UIButton()
    let tagButton2 = UIButton()
    let tagButton3 = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Top Navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()
        
        // Content Body
        setUpTitle()
        setupSubTitle()
        setupTags()
        setupTagButtons()
        setupBodyContainer()
        addToBodyContainer(views: [self.titleLabel, self.textField])
        print("Tag")
     }
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
     }
    override func setupSubTitle() {
        super.setupSubTitle()
        self.subtitleLabel.text = subtitle
    }
    func setupTagContainers(){
        
    }
    
    func setupTags(){
        tag1.text = "Tag 1:"
        tag1.textColor = UIColor.black
        tag1.font = tag1.font.withSize(20)
        tag1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tag1)
        NSLayoutConstraint.activate([
            tag1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 270.0),
            tag1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50.0),
            tag1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        tag2.text = "Tag 2:"
        tag2.textColor = UIColor.black
        tag2.font = tag2.font.withSize(20)
        tag2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tag2)
        NSLayoutConstraint.activate([
            tag2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 370.0),
            tag2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50.0),
            tag2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        tag3.text = "Tag 3:"
        tag3.textColor = UIColor.black
        tag3.font = tag3.font.withSize(20)
        tag3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tag3)
        NSLayoutConstraint.activate([
            tag3.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 470.0),
            tag3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50.0),
            tag3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
    }
    func setupTagButtons(){
        tagButton1.backgroundColor = .white
        tagButton1.layer.borderColor = UIColor.lightGray.cgColor
        tagButton1.layer.borderWidth = 1.0
        tagButton1.layer.cornerRadius = 8.0
        tagButton1.layer.masksToBounds = true
        tagButton1.setTitle("Add tag", for: .normal)
        tagButton1.setTitleColor(.black, for: .normal)
        tagButton1.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tagButton1)
        tagButton1.addTarget(self, action: #selector(categoryButtonTap(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            tagButton1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 265.0),
            tagButton1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150.0),
            tagButton1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
        ])
        
        tagButton2.backgroundColor = .white
        tagButton2.layer.borderColor = UIColor.lightGray.cgColor
        tagButton2.layer.borderWidth = 1.0
        tagButton2.layer.cornerRadius = 8.0
        tagButton2.layer.masksToBounds = true
        tagButton2.setTitle("Add tag", for: .normal)
        tagButton2.setTitleColor(.black, for: .normal)
        tagButton2.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tagButton2)
        tagButton2.addTarget(self, action: #selector(categoryButtonTap(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            tagButton2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 365.0),
            tagButton2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150.0),
            tagButton2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
        ])
        
        tagButton3.backgroundColor = .white
        tagButton3.layer.borderColor = UIColor.lightGray.cgColor
        tagButton3.layer.borderWidth = 1.0
        tagButton3.layer.cornerRadius = 8.0
        tagButton3.layer.masksToBounds = true
        tagButton3.setTitle("Add tag", for: .normal)
        tagButton3.setTitleColor(.black, for: .normal)
        tagButton3.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tagButton3)
        tagButton3.addTarget(self, action: #selector(categoryButtonTap(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            tagButton3.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 465.0),
            tagButton3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 150.0),
            tagButton3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
        ])
    }
    @objc func categoryButtonTap(_ sender: UIButton){
        catPicker = UIPickerView.init()
        catPicker.delegate = self as UIPickerViewDelegate
        catPicker.dataSource = self as UIPickerViewDataSource
        catPicker.backgroundColor = UIColor.white
        catPicker.setValue(UIColor.black, forKey: "textColor")
        catPicker.translatesAutoresizingMaskIntoConstraints = false
        catPicker.contentMode = .center
        self.view.addSubview(catPicker)
        if sender == tagButton1{
            NSLayoutConstraint.activate([
                catPicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 135.0),
                catPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 116.0),
                catPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
            ])
            doneButton1.backgroundColor = .white
            doneButton1.setTitle("Done", for: .normal)
            doneButton1.setTitleColor(.systemTeal, for: .normal)
            doneButton1.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(doneButton1)
            doneButton1.addTarget(self, action: #selector(onDoneButtonTapped(_:)), for: .touchUpInside)
            NSLayoutConstraint.activate([
                doneButton1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
                doneButton1.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 250.0),
                doneButton1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.0)
            ])
        }else if sender == tagButton2{
            NSLayoutConstraint.activate([
                catPicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 235.0),
                catPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 116.0),
                catPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
            ])
            doneButton2.backgroundColor = .white
            doneButton2.setTitle("Done", for: .normal)
            doneButton2.setTitleColor(.systemTeal, for: .normal)
            doneButton2.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(doneButton2)
            doneButton2.addTarget(self, action: #selector(onDoneButtonTapped(_:)), for: .touchUpInside)
            NSLayoutConstraint.activate([
                doneButton2.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 250.0),
                doneButton2.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 250.0),
                doneButton2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.0)
            ])
        }else if sender == tagButton3{
            NSLayoutConstraint.activate([
                catPicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 335.0),
                catPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 116.0),
                catPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
            ])
            doneButton3.backgroundColor = .white
            doneButton3.setTitle("Done", for: .normal)
            doneButton3.setTitleColor(.systemTeal, for: .normal)
            doneButton3.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(doneButton3)
            doneButton3.addTarget(self, action: #selector(onDoneButtonTapped(_:)), for: .touchUpInside)
            NSLayoutConstraint.activate([
                doneButton3.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 350.0),
                doneButton3.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 250.0),
                doneButton3.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.0)
            ])
        }
    }
    @objc func onDoneButtonTapped(_ sender: UIButton) {
        var chosenCat = ""
        chosenCat = catArray[catPicker.selectedRow(inComponent: 0)]
        if sender == doneButton1{
            tagButton1.setTitle(chosenCat, for: .normal)
            tagButton1.layer.borderColor = UIColor.green.cgColor
            doneButton1.removeFromSuperview()
        }else if sender == doneButton2{
            tagButton2.setTitle(chosenCat, for: .normal)
            tagButton2.layer.borderColor = UIColor.cyan.cgColor
            doneButton2.removeFromSuperview()
        }else if sender == doneButton3{
            tagButton3.setTitle(chosenCat, for: .normal)
            tagButton3.layer.borderColor = UIColor.systemPurple.cgColor
            doneButton3.removeFromSuperview()
        }
        catPicker.removeFromSuperview()
    }
    
     func numberOfComponents(in pickerView: UIPickerView) -> Int {
         return 1
     }
     
     func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
         return catArray.count
     }
     
     func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         let row = catArray[row]
         return row
     }
}


}
