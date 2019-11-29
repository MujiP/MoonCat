//
//  CreateEvent_VC.swift
//  MoonCat
//
//  Created by user158070 on 11/8/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import PromiseKit

class CreateEvent_VC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
   
    let catArray = ["Coffee", "Food", "Study", "Other"] // event categories
    var showContact = true// boolean flag for whether user wants to display contact inf
    
    
    // toolbars
    var startDoneBar = UIToolbar()
    var endDoneBar = UIToolbar()
    
    // buttons
    var doneButton = UIButton(type:.system)
    var catButton = UIButton(type:.system)
    // all pickers
    var catPicker = UIPickerView()
    var startDatePicker = UIDatePicker()
    var endDatePicker = UIDatePicker()
    
    // all textfields to read from
    var eventName = UITextField()
    var location = UITextField()
    var descrip = UITextField()
    var maxNum = UITextField()
    var contactInfo = UITextField()
    var startDateText = UITextField()
    var endDateText = UITextField()
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    /*
     code for moving the view when keyboard pops up
  
    @objc func keyboardWillShow(notification: NSNotification){
        guard let keyboardInfo = notification.userInfo else {return}
        guard let keyboardSize = keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification){
        guard let keyboardInfo = notification.userInfo else {return}
        guard let keyboardSize = keyboardInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardFrame.height
        }
    } */

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        setupTitleBar()
        setupEventLabel()
        setupLocationLabel()
        setupCategoryLabel()
        setupStartTimeLabel()
        setupEndTimeLabel()
        setupDescriptionLabel()
        setupMaxNumLabel()
        setupContactLabel()
        setupCreateButton()
        setupDismissButton()
        
        /* code for moving the view when keyboard pops up
        NotificationCenter.default.addObserver(self, selector: #selector(CreateEvent_VC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(CreateEvent_VC.keyboardWillHide), name: UIResponder.keyboardDidHideNotification, object: nil)*/
    }
    
    func setupEventLabel(){
        // enter event name
        let eventLabel = UILabel()
        eventLabel.numberOfLines = 0
        eventLabel.textAlignment = .left
        eventLabel.text = "EVENT NAME"
        eventLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(eventLabel)
        NSLayoutConstraint.activate([
            eventLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 70.0),
            eventLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            eventLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100.0)
        ])
        
        eventName.backgroundColor = .white
        eventName.borderStyle = .roundedRect
        eventName.layer.cornerRadius = 8.0
        eventName.layer.masksToBounds = true
        eventName.layer.borderWidth = 1.0
        eventName.layer.borderColor = UIColor.lightGray.cgColor
        eventName.delegate = self
        eventName.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(eventName)
        NSLayoutConstraint.activate([
            eventName.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100.0),
            eventName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            eventName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
    }
    
    func setupLocationLabel(){
        // enter location
        let locationLabel = UILabel()
        locationLabel.numberOfLines = 0
        locationLabel.textAlignment = .left
        locationLabel.text = "LOCATION"
        locationLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationLabel)
        NSLayoutConstraint.activate([
            locationLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
            locationLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            locationLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100.0)
        ])
        
        location.backgroundColor = .white
        location.borderStyle = .roundedRect
        location.layer.cornerRadius = 8.0
        location.layer.masksToBounds = true
        location.layer.borderWidth = 1.0
        location.layer.borderColor = UIColor.lightGray.cgColor
        location.delegate = self
        location.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(location)
        NSLayoutConstraint.activate([
            location.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 180.0),
            location.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            location.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
    }
    
    func setupTitleBar(){
        // top purple bar with title of create event page
        let topView = UIView()
        topView.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(topView)
        topView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        topView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        topView.heightAnchor.constraint(equalToConstant: view.frame.height/9).isActive = true
        
        // add title
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.text = "Create your own event!"
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16.0),
            titleLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16.0)
        ])

    }
    
    func setupCategoryLabel(){
        // select category label
        
        let catLabel = UILabel()
        catLabel.numberOfLines = 0
        catLabel.textAlignment = .left
        catLabel.text = "CATEGORY"
        catLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        catLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(catLabel)
        NSLayoutConstraint.activate([
            catLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 235.0),
            catLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            catLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100.0)
        ])
        
        catButton.backgroundColor = .lightGray
        catButton.setTitle("Select Category", for: .normal)
        catButton.setTitleColor(.black, for: .normal)
        catButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(catButton)
        catButton.addTarget(self, action: #selector(categoryButtonTap(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            catButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 230.0),
            catButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 116.0),
            catButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
    }
    
    func setupStartTimeLabel(){
        // choose start time (date picker)
        let startLabel = UILabel()
        startLabel.numberOfLines = 0
        startLabel.textAlignment = .left
        startLabel.text = "START TIME"
        startLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        startLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(startLabel)
        NSLayoutConstraint.activate([
            startLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 280.0),
            startLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            startLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100.0)
        ])
        
        // tap button to choose start time from date picker
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
        self.view.addSubview(startDateText)
        NSLayoutConstraint.activate([
            startDateText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 275.0),
            startDateText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120.0),
            startDateText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0)
        ])
    }
    
    func setupEndTimeLabel(){
        // choose end time (date picker)
        let endLabel = UILabel()
        endLabel.numberOfLines = 0
        endLabel.textAlignment = .left
        endLabel.text = "END TIME"
        endLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        endLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(endLabel)
        NSLayoutConstraint.activate([
            endLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 320.0),
            endLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            endLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10.0)
        ])
        
        endDateText.backgroundColor = .white
        endDateText.borderStyle = .roundedRect
        endDateText.layer.cornerRadius = 8.0
        endDateText.layer.masksToBounds = true
        endDateText.layer.borderWidth = 1.0
        endDateText.layer.borderColor = UIColor.lightGray.cgColor
        endDateText.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.datePickerMode  = .dateAndTime
        endDatePicker.backgroundColor = .white
        endDateText.inputView = endDatePicker
        createEndToolBar() // create the tool bar for date picker
        endDateText.inputAccessoryView = endDoneBar
        self.view.addSubview(endDateText)
        NSLayoutConstraint.activate([
            endDateText.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 315.0),
            endDateText.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 120.0),
            endDateText.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0)
        ])
    }
    
    func setupDescriptionLabel(){
        // enter event description
        let descripLabel = UILabel()
        descripLabel.numberOfLines = 0
        descripLabel.textAlignment = .left
        descripLabel.text = "DESCRIPTION"
        descripLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        descripLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descripLabel)
        NSLayoutConstraint.activate([
            descripLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 360.0),
            descripLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            descripLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -100.0)])
        
        descrip.backgroundColor = .white
        descrip.borderStyle = .roundedRect
        descrip.layer.cornerRadius = 8.0
        descrip.layer.masksToBounds = true
        descrip.layer.borderWidth = 1.0
        descrip.layer.borderColor = UIColor.lightGray.cgColor
        descrip.delegate = self
        descrip.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(descrip)
        NSLayoutConstraint.activate([
            descrip.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 390.0),
            descrip.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            descrip.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0),
            descrip.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func setupMaxNumLabel(){
        // set maximum number of people (drop down menu)
        let maxNumLabel = UILabel()
        maxNumLabel.numberOfLines = 0
        maxNumLabel.textAlignment = .left
        maxNumLabel.text = "MAX. NUMBER OF PEOPLE"
        maxNumLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        maxNumLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(maxNumLabel)
        NSLayoutConstraint.activate([
            maxNumLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 470.0),
            maxNumLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            maxNumLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
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
            maxNum.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 465.0),
            maxNum.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 295.0),
            maxNum.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
    }
    
    func setupContactLabel(){
        
        // choose yes or no to showing contact info
        let contactLabel = UILabel()
        contactLabel.numberOfLines = 0
        contactLabel.textAlignment = .left
        contactLabel.text = "SHOW CONTACT INFO"
        contactLabel.textColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        contactLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contactLabel)
        NSLayoutConstraint.activate([
            contactLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 530.0),
            contactLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0),
            contactLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
        ])
        
        // create switch for choosing to show contact info
        let contactSwitch = UISwitch()
        contactSwitch.onTintColor = .green
        contactSwitch.tintColor = .white
        contactSwitch.addTarget(self, action: #selector(switchStateChange), for: .valueChanged)
        contactSwitch.setOn(true, animated: false)
        contactSwitch.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(contactSwitch)
        NSLayoutConstraint.activate([
            contactSwitch.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 525.0),
            contactSwitch.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 303.0),
            contactSwitch.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.0)
        ])
    }
    
    func setupCreateButton(){
        // button for creating events
        let createButton = UIButton(type:.system)
        createButton.backgroundColor = .green
        createButton.setTitle("Create", for: .normal)
        createButton.setTitleColor(.black, for: .normal)
        createButton.layer.cornerRadius = 10
        createButton.frame.size = CGSize(width: 60, height: 60)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.addTarget(self, action: #selector(createButtonTap(_:)), for: .touchUpInside)
        self.view.addSubview(createButton)
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 580.0),
            createButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50.0),
            createButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50.0)
        ])
    }
    
    func setupDismissButton(){
        //add DISMISS button
        let dismissButton = UIButton()
        dismissButton.backgroundColor = #colorLiteral(red: 0.4549019608, green: 0.2745098039, blue: 0.9529411765, alpha: 1)
        dismissButton.setTitle("Dismiss", for: .normal)
        dismissButton.setTitleColor(.white, for: .normal)
        dismissButton.layer.cornerRadius = 10
        dismissButton.layer.borderColor = UIColor.white.cgColor
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.addTarget(self, action: #selector(dismissTap(_:)), for: .touchUpInside)
        self.view.addSubview(dismissButton)
        NSLayoutConstraint.activate([
            dismissButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5.0),
            dismissButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 300.0),
            dismissButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.0)
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
        NSLayoutConstraint.activate([
            catPicker.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 135.0),
            catPicker.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 116.0),
            catPicker.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0)
        ])
        
        doneButton.backgroundColor = .white
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.systemTeal, for: .normal)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(doneButton)
        doneButton.addTarget(self, action: #selector(onDoneButtonTapped(_:)), for: .touchUpInside)
        NSLayoutConstraint.activate([
            doneButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
            doneButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 250.0),
            doneButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5.0)
        ])
        
    }
    @objc func onDoneButtonTapped(_ sender: UIButton) {
        var chosenCat = ""
        chosenCat = catArray[catPicker.selectedRow(inComponent: 0)]
        catButton.setTitle(chosenCat, for: .normal)
        catPicker.removeFromSuperview()
        doneButton.removeFromSuperview()
    }
    
    @objc func switchStateChange(_ sender: UISwitch){
        if (sender.isOn == true){
            showContact = true
            print("switch on")
        }else{
            showContact = false
            print("switch off")
        }
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
    
    func createEndToolBar(){
        // set up tool bar
        endDoneBar.autoresizingMask = .flexibleHeight
        endDoneBar.barStyle = .default
        endDoneBar.barTintColor = .white
        endDoneBar.backgroundColor = .white
        endDoneBar.isTranslucent = false
        
        // add done button to toolbar
        let endDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(endButtonTap(_:)))
        endDoneButton.tintColor = .systemTeal
        endDoneBar.items = [endDoneButton]
    }
    
    @objc func startButtonTap(_ button: UIBarButtonItem){
        // close date picker
        startDateText.resignFirstResponder()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm"
        startDateText.text = format.string(from: startDatePicker.date)
    }
    
    @objc func endButtonTap(_ button: UIBarButtonItem){
        // close date picker
        endDateText.resignFirstResponder()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm"
        endDateText.text = format.string(from: endDatePicker.date)
    
    }
    
    /*
     When the create button is tapped, create a new EventInfo instance, store all the values the user inputted in this
     object.
     */
    @objc func createButtonTap(_ sender: UIButton){
        let eventInformation = EventInfo(
            eventName: eventName.text!,
            location: location.text!,
            category: catButton.currentTitle!,
            startTime: startDateText.text!,
            endTime: endDateText.text!,
            description: descrip.text!,
            maxNumPeople: maxNum.text!,
            showContact: showContact
        )
        
        firstly {
            🎟Event(eventInformation).run()
        }.done { _ in
            print("done")
        }.catch { error in
            print(error)
        }
        
    }
    
    // tap action function for DISMISS Button
    @objc func dismissTap(_ sender:UIButton){
        self.leave()
    }

}
