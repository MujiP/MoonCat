//
//  EventCreationLayouts_VC.swift
//  MoonCat
//
//  Created by Kirk Lu on 11/30/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import TagListView

// MARK: - Description Entry
class DescEntryPage: EventCreationPage_VC, UITextViewDelegate{

    var pageTitle = "Tell people more about your awesome event!"
    var placeholder = "Say..."

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTopDecor(color: .groupTableViewBackground)
        setupTopNavigation()
        setupTextField()
        setUpTitle()
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.textField], container: bodyContainer)
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
        }
        
    }
       
    func textViewDidEndEditing(_ textView: UITextView) {
        if textField.text == ""{
            textField.text = placeholder
            textField.textColor = UIColor.lightGray
        }
        self.eventDB.eventDesc = ""
        self.eventDB.eventDesc += textField.text
    }
       
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            textViewDidEndEditing(textField)
            textField.resignFirstResponder()
        }
        
        // limit max input length
        return textView.text.count + (text.count - range.length) <= 140

    }

}

// MARK: - Time Selection
class TimeSelectPage: EventCreationPage_VC, UITextFieldDelegate{
    let doneTimePick = UIToolbar.init(frame: .init(x: 0, y: 0, width: 100, height: 100))
    let pageTitle = "When is it happening..?"
    let timePicker = UIDatePicker()
    let startTimeText = PickerTextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.bodyContainer.isLayoutMarginsRelativeArrangement = true
        // Top Navigation
        setupTopDecor(color: .groupTableViewBackground)
        setupTopNavigation()

        // Body Content
        setUpTitle()
        setUpStartTime()
        
        setUpSlotContainer()
        slotContainer.addArrangedSubview(startTimeText)

        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.slotContainer], container: bodyContainer)
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
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
        
        // Bug with autoresizing
        // doneTimePick.autoresizingMask = .flexibleHeight
        doneTimePick.translatesAutoresizingMaskIntoConstraints = false
        
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
        self.eventDB.startDateTime = startTimeText.text!
    }

}

    
// MARK: - Location Entry
class LocationEntryPage: EventCreationPage_VC, UITextFieldDelegate{
    let pageTitle = "Set a location. \n Anywhere around campus"
    let placeholder = "Search here .."
    let locationText = PickerTextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupTopDecor(color: .groupTableViewBackground)
        setupTopNavigation()
        setUpTitle()
        setupLocation()
        
        setUpSlotContainer()
        slotContainer.addArrangedSubview(locationText)
        
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, slotContainer], container: bodyContainer)
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
        
        // Specify bounds
        let neBoundsCorner = CLLocationCoordinate2D(latitude: 43.673129, longitude: -79.414361)
        let swBoundsCorner = CLLocationCoordinate2D(latitude: 43.654482, longitude: -79.369620)
        autocompleteController.autocompleteBounds = GMSCoordinateBounds(coordinate: neBoundsCorner, coordinate: swBoundsCorner)


        // Specify the place data types to return.
        let fields: GMSPlaceField = GMSPlaceField(rawValue: GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
            UInt(GMSPlaceField.placeID.rawValue))!.rawValue | UInt(GMSPlaceField.formattedAddress.rawValue))!
        autocompleteController.placeFields = fields

        // Specify a filter.
        let filter = GMSAutocompleteFilter()
        filter.type = .establishment
        autocompleteController.autocompleteFilter = filter

        // Display the autocomplete view controller.
        present(autocompleteController, animated: true, completion: nil)
    }
    
    
    // MARK: - Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        if place.formattedAddress != nil {
            let address = place.formattedAddress!
            let slice = address.firstIndex(of: ",")!
            let area = address[...address.index(slice, offsetBy :-1)]
            self.eventDB.area = String(area)
        }
        
        self.locationText.text = place.name
        
        // MARK: - LocationData
        self.eventDB.location = locationText.text!
        
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
class TagEntryPage: EventCreationPage_VC{
    
    var tagList = TagListView()
    let pageTitle = "Tag it \n & Make it easy"
    
    var coffeeInitialized = false
    var movieInitialized = false
    var foodInitialized = false
    var studyInitialized = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setUpTagList()
        setTags()
        
        
        setupTopDecor(color: .groupTableViewBackground)
        setupTopNavigation()
        setUpTitle()
        setupBodyContainer()
        addToContainer(views: [titleLabel, tagList], container: bodyContainer)
    }
    
    func setUpTagList() {
        tagList.delegate = self
        tagList.textFont = .systemFont(ofSize: 20)
        tagList.shadowRadius = 2
        tagList.shadowOpacity = 0.4
        tagList.shadowColor = UIColor.black
        tagList.shadowOffset = CGSize(width: 1, height: 1)
        tagList.tagBackgroundColor = .lightGray
        tagList.alignment = .center
        tagList.tagSelectedBackgroundColor = .systemTeal
        tagList.cornerRadius = 5
    }
    
    func setTags() {
        let coffeeTags = tagList.addTag("Coffee")
        coffeeTags.onTap = { coffeeTags in
            if !self.coffeeInitialized{
                self.tagList.addTags(["Chill", "Bubble Tea", "Walking", "Coffee House"])
                self.coffeeInitialized = true
            }
        }
        let movieTags = tagList.addTag("Movie")
        movieTags.onTap = { movieTags in
            if !self.movieInitialized{
                self.tagList.addTags(["Marvel Movie", "Disney Movie", "Indie Movie", "Popcorn Movie", "Korean Movie"])
                self.movieInitialized = true
            }
        }
        let foodTags = tagList.addTag("Food")
        foodTags.onTap = { FoodTags in
            if !self.foodInitialized{
                self.tagList.addTags(["Hotpot", "Pizza", "BBQ", "Sushi"])
                self.foodInitialized = true
            }
        }
        
        let studyTags = tagList.addTag("Study")
        studyTags.onTap = { studyTags in
            if !self.studyInitialized{
                self.tagList.addTags(["CSC", "PHL", "PSY", "ECO", "MAT", "POL"])
                self.studyInitialized = true
            }
        }

    }
    
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
     }
}

extension TagEntryPage: TagListViewDelegate{
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        // print("Tag pressed: \(title), \(sender)")
        if tagView.isSelected{
            self.eventDB.tags.removeAll{$0 == title}
        } else {
            self.eventDB.tags.append(title)
        }
        tagView.isSelected = !tagView.isSelected
        
    }
}


// MARK: - Max Number of people
class MemberRestrainPage: EventCreationPage_VC, UIPickerViewDataSource, UIPickerViewDelegate{
    let pageTitle = "How many people would you prefer there to be?"
    let numPicker = UIPickerView()
    let createButton = UIButton()
    var numValue = [String]()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Top Navigation
        setupTopDecor(color: .groupTableViewBackground)
        setupTopNavigation()

        // Body Content
        setUpTitle()
        setUpValue()
        setUpPicker()
        setUpCreateButton()
        
        setupBodyContainer()
        addToContainer(views: [titleLabel, numPicker, createButton], container: bodyContainer)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.eventDB.dataSanityCheckPassed() {
            self.createButton.isEnabled = true
        }
    }
     
    override func setUpTitle() {
         super.setUpTitle()
         self.titleLabel.text = pageTitle
    }
    
    func setUpPicker(){
        numPicker.dataSource = self
        numPicker.delegate = self
        numPicker.layer.cornerRadius = 20
        numPicker.backgroundColor = .groupTableViewBackground
    }
    
    func setUpValue(){
        for i in 1...15{
            numValue.append(String(i))
        }
        numValue.append("Unlimited")
    }
    
    func setUpCreateButton(){
        createButton.setTitle("Create!", for: .normal)
        createButton.setTitleColor(.systemBlue, for: .normal)
        createButton.setTitleColor(.systemGray, for: .disabled)
        createButton.addTarget(self, action: #selector(self.didFinishCreateEvent), for: .touchUpInside)
        createButton.isEnabled = false
    }
    
    override func didFinishCreateEvent() {
        self.eventDB.maxPeople = self.pickerView(numPicker, titleForRow: numPicker.selectedRow(inComponent: 0), forComponent: 0)!
        super.didFinishCreateEvent()
    }
    
    // Picker data source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numValue.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return numValue[row]
    }
    
}
    

// MARK: - Designs
// live color
class live: DescEntryPage {

    override func viewDidLoad() {
        view.backgroundColor = .systemYellow
        
        // Top navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.80))
        setupTopNavigation()
        
        // Body Content
        setUpTitle()
        setupTextField()
        textField.backgroundColor = .init(white: 0.95, alpha: 0.5)
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, self.textField], container: bodyContainer)
    }
}

// live 2
class live2: TimeSelectPage{
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBlue
        self.bodyContainer.isLayoutMarginsRelativeArrangement = true
        // Top Navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.70))
        setupTopNavigation()

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
    }

}

// live3
class live3: LocationEntryPage {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGreen
        
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.70))
        setupTopNavigation()
        setUpTitle()
        setupLocation()
        
        setUpSlotContainer()
        slotContainer.addArrangedSubview(locationText)
        
        setupBodyContainer()
        addToContainer(views: [self.titleLabel, slotContainer], container: bodyContainer)
    }
    
}

// live4
class live4: TagEntryPage {
    override func viewDidLoad() {
        view.backgroundColor = .systemRed
        setUpTagList()
        tagList.tagBackgroundColor = UIColor.init(white: 1, alpha: 0.70)
        tagList.textColor = .white
        tagList.textFont = .systemFont(ofSize: 20, weight: .medium)
        setTags()
        
        
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.70))
        setupTopNavigation()
        setUpTitle()
        titleLabel.textColor = .white

        setupBodyContainer()
        addToContainer(views: [titleLabel, tagList], container: bodyContainer)
    }
}

// live5
class live5: MemberRestrainPage {
    
    override func viewDidLoad() {
        view.backgroundColor = .systemOrange
        // Top Navigation
        setupTopDecor(color: UIColor.init(white: 1, alpha: 0.70))
        setupTopNavigation()

        // Body Content
        setUpTitle()
        setUpValue()
        setUpPicker()
        numPicker.backgroundColor = UIColor.init(white: 1, alpha: 0.70)
        numPicker.layer.cornerRadius = 20
        setUpCreateButton()
        
        setupBodyContainer()
        addToContainer(views: [titleLabel, numPicker, createButton], container: bodyContainer)
    }
}
