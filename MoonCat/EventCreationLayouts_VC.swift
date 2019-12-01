//
//  EventCreationLayouts_VC.swift
//  MoonCat
//
//  Created by Kirk on 11/30/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import GooglePlaces

// MARK: - description
class DescEntryPage: EventCreationPage_VC, UITextViewDelegate{

    var placeholder = "Let others know what your event is about..."
    var pageTitle = "Event Description"
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTopDecor(color: .groupTableViewBackground)
        setupTopControl()
        setupTextField()
        setUpTitle()
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.textField], container: bodyContainer)
        print("Description")
    }
    
   override func setUpTitle() {
        super.setUpTitle()
        self.titleLabel.text = pageTitle
    }
    
   override func setupTextField(){
        super.setupTextField()
        self.textField.text = placeholder
        textField.delegate = self
    }
    
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

// MARK: - Time Selection
class TimeSelectPage: EventCreationPage_VC, UITextFieldDelegate{
    let doneTimePick = UIToolbar()
    let pageTitle = "When is it happening..?"
    let timePicker = UIDatePicker()
    let startTimeText = PickerTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.bodyContainer.isLayoutMarginsRelativeArrangement = true
        // Top Navigation
        setupTopDecor(color: .groupTableViewBackground)
        setupTopControl()

        // Body Content
        setUpTitle()
        setUpStartTime()
        
        setUpSlotContainer()
        slotContainer.addArrangedSubview(startTimeText)

        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.slotContainer], container: bodyContainer)
        print("Time")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//            startTimeText.becomeFirstResponder()
//    }
    
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
    }
        
    func setUptimeSlotContainer(){
        slotContainer.axis = .vertical
        slotContainer.layoutMargins =
            UIEdgeInsets(top: 0,
                        left: view.frame.width / 8,
                        bottom:view.frame.height / 3,
                        right: view.frame.width / 8)
        slotContainer.isLayoutMarginsRelativeArrangement = true
        slotContainer.distribution = .fillEqually
    }
    
    func setUpStartTime(){
        // shape style
        startTimeText.backgroundColor = .white
        startTimeText.borderStyle = .roundedRect
        startTimeText.layer.cornerRadius = 8.0
        startTimeText.layer.masksToBounds = true
        startTimeText.layer.borderWidth = 1.0
        startTimeText.layer.borderColor = UIColor.lightGray.cgColor
        startTimeText.translatesAutoresizingMaskIntoConstraints = false
        
        // text style
        startTimeText.text = "Pick a time ../"
        startTimeText.textColor = UIColor.lightGray
        startTimeText.font = UIFont(name: "verdana", size: 14.0)
        startTimeText.textAlignment = .center
        startTimeText.delegate = self
        
        // picker
        timePicker.datePickerMode  = .dateAndTime
        timePicker.backgroundColor = .white
        startTimeText.inputView = timePicker
        createStartToolBar() // create the tool bar for date picker
        startTimeText.inputAccessoryView = doneTimePick
    }

    func createStartToolBar(){
        // set up tool bar
        doneTimePick.autoresizingMask = .flexibleHeight
        doneTimePick.barStyle = .default
        doneTimePick.barTintColor = .white
        doneTimePick.backgroundColor = .white
        doneTimePick.isTranslucent = false
        
        // add done button to toolbar
        let startDoneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(startButtonTap(_:)))
        startDoneButton.tintColor = .systemTeal
        doneTimePick.items = [startDoneButton]
    }
    
    @objc func startButtonTap(_ button: UIBarButtonItem){
        // close date picker
        startTimeText.resignFirstResponder()
        let format = DateFormatter()
        format.dateFormat = "dd-MM-yyyy HH:mm"
        startTimeText.text = format.string(from: timePicker.date)
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
        view.backgroundColor = .white
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
}
    
// MARK: - Location Entry
class LocationEntryPage: EventCreationPage_VC, UITextFieldDelegate{
    let pageTitle = "Set a location"
    let placeholder = "Search here .."
    let locationText = PickerTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTopDecor(color: .groupTableViewBackground)
        setupTopControl()
        setUpTitle()
        setupLocation()
        
        setUpSlotContainer()
        slotContainer.addArrangedSubview(locationText)
        
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, slotContainer], container: bodyContainer)
        print("Location")
    }
    
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
     }
     
    func setupLocation(){
        locationText.delegate = self
        // shape style
        locationText.backgroundColor = .white
        locationText.borderStyle = .roundedRect
        locationText.layer.cornerRadius = 8.0
        locationText.layer.masksToBounds = true
        locationText.layer.borderWidth = 1.0
        locationText.layer.borderColor = UIColor.lightGray.cgColor

        
        // text style
        locationText.text = placeholder
        locationText.textColor = UIColor.lightGray
        locationText.font = UIFont(name: "verdana", size: 14.0)
        locationText.textAlignment = .center
        locationText.addTarget(self, action: #selector(autocompleteClicked), for: .editingDidBegin)
        locationText.layoutMargins =
        UIEdgeInsets(top: 0,
                    left: view.frame.width / 8,
                    bottom:view.frame.height / 3,
                    right: view.frame.width / 8)
    }
    
    
}

// Google places search layout
extension LocationEntryPage: GMSAutocompleteViewControllerDelegate{
    
    // Present the Autocomplete view controller when the textview is pressed.
    @objc func autocompleteClicked(_ sender: UITextView) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self

        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        UInt(GMSPlaceField.placeID.rawValue))!
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    // MARK: - Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {

        
        self.locationText.text = place.name
        //TODO: store place data
        // print("Place name: \(place.name)")
        // print("Place ID: \(place.placeID)")
        // print("Place attributions: \(place.attributions)")
        
        dismiss(animated: true, completion: nil)
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }

    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }

    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }

    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
        view.backgroundColor = .white
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
        addToContainer(views: [self.titleLabel, self.textField], container: bodyContainer)
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
    

// MARK: - Designs
// live color
class live: DescEntryPage {

    override func viewDidLoad() {
        view.backgroundColor = .systemYellow
        
        // Top navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopControl()
        
        // Body Content
        setUpTitle()
        setupTextField()
        textField.backgroundColor = .init(white: 0.95, alpha: 0.5)
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.textField], container: bodyContainer)
        print("live")
    }
    
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = "Tell people more about your awesome event!"
     }
     
    override func setupTextField(){
         super.setupTextField()
         self.textField.text = "Say..."
         textField.delegate = self
     }
}

// live 2
class live2: TimeSelectPage{
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
        self.bodyContainer.isLayoutMarginsRelativeArrangement = true
        // Top Navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.70))
        setupTopControl()

        // Body Content
        setUpTitle()
        titleLabel.textColor = UIColor.init(white: 0.95, alpha: 0.9)
        setUpStartTime()
        startTimeText.backgroundColor = UIColor.init(white: 0.95, alpha: 0.5)
        startTimeText.textColor = .white
        
        setUptimeSlotContainer()

        slotContainer.addArrangedSubview(startTimeText)


        
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.slotContainer], container: bodyContainer)
        print("Time")
    }
    
    

}
