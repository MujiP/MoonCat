//
//  ViewController.swift
//  MoonCat
//
//  Created by Si Yu Zhuang on 11/28/19.
//  Copyright © 2019 Bolusaur. All rights reserved.
//
import UIKit


// Parent VC for one page to be extend and/or override
class EventCreationPage_VC: UIViewController{
    // MARK: - Shard View Initialization
    // Top navigation
    let topDecorator = UIView()    // Colored background
    let topControl = UIStackView() // Navigation with horizontal stack view or..
    let topNavigation = UINavigationBar() // Navigation with normal navigation bar
    
    // Body containers
    let bodyContainer = UIStackView()   // Whole body vertical stack containter
    let slotContainer = UIStackView()   // Nested stack container
    
    // Titles
    let titleLabel = UILabel()      // instruction
    let subtitleLabel = UILabel()   // more


    var textField = UITextView()    // Simple DataEntry point
    
    // MARK: - Data Initialzation
    var eventDesc = String()
    var startDateTime = String()
    var location = String()
    var aera = String()
    var maxPeople = String()
    var tags = [String]()

    
    
// MARK: - Controls
    @objc func didFinishCreateEvent(){
        print(eventDesc)
        print(startDateTime)
        print(location)
        print(maxPeople)
        assert(!eventDesc.isEmpty)
        assert(!startDateTime.isEmpty)
        assert(!location.isEmpty)
        assert(!maxPeople.isEmpty)

        //MARK: ------ export data here: -------
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func cancelEventCreation(){
        reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func reloadData(){
        eventDesc = ""
        startDateTime = ""
        location = ""
        maxPeople = ""
        tags.removeAll()
    }

// MARK: - Shared Views
    
    // MARK: - TopNavigation
    func setupTopNavigation(){
        // Hacky transparent
        topNavigation.setBackgroundImage(UIImage(), for: .default)
        topNavigation.shadowImage = UIImage()
        topNavigation.isTranslucent = true

        
        // system icon
        topNavigation.tintColor = .black
        let navItem = UINavigationItem(title: "")
        // let create = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: nil)
        let cancel = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(cancelEventCreation))
        navItem.rightBarButtonItem = cancel
        // navItem.rightBarButtonItem = create
        topNavigation.setItems([navItem], animated: true)
        
        // Auto layout
        view.insertSubview(topNavigation, aboveSubview: topDecorator)
        topNavigation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topNavigation.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            topNavigation.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            topNavigation.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            topNavigation.heightAnchor.constraint(equalToConstant: view.frame.height/18)
        ])
    }
    
    // Unused
    func setupTopControl() {
        
        // Button
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.systemBlue, for: .normal)
        cancelButton.addTarget(self, action: #selector(self.cancelEventCreation), for: .touchUpInside)


        // reserved button - unused
        let createButton = UIButton(type: .custom)
        createButton.setTitle("", for: .normal)
        createButton.setTitleColor(.systemGray, for: .disabled)
        createButton.setTitleColor(.systemBlue, for: .normal)
        createButton.addTarget(self, action: #selector(self.didFinishCreateEvent), for: .touchUpInside)
        
        createButton.isEnabled = false

        
        // reserved title - unused
        let topTitle = UILabel()
        topTitle.numberOfLines = 0
        topTitle.textAlignment = .center
        topTitle.text = " "
        topTitle.textColor = UIColor.black
        topTitle.adjustsFontSizeToFitWidth = false
        topTitle.font = .boldSystemFont(ofSize: 20)
        
        // Stack setup
        topControl.addArrangedSubview(createButton)
        topControl.addArrangedSubview(topTitle)
        topControl.addArrangedSubview(cancelButton)


        topControl.axis = .horizontal
        topControl.distribution = .fillEqually
        
        // autolayout
        view.addSubview(topControl)
        topControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topControl.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            topControl.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            topControl.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            topControl.heightAnchor.constraint(equalToConstant: view.frame.height/18)
        ])
    }
    
    // Top Navigtion Background Setup
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
            bodyContainer.topAnchor.constraint(equalTo:topNavigation.bottomAnchor),
            bodyContainer.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor),
            bodyContainer.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor),
            bodyContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
        // MARK: - FIX THISSSSSSSSSSSSSSS
    func setUpSlotContainer(){
        slotContainer.axis = .vertical
        slotContainer.layoutMargins =
            UIEdgeInsets(top: 0,
                        left: view.frame.width / 8,
                        bottom:view.frame.height / 3,
                        right: view.frame.width / 8)
        slotContainer.isLayoutMarginsRelativeArrangement = true
        slotContainer.distribution = .fillEqually
    }
    
    // Add views into page body from top down
    func addToContainer(views: Array<UIView>, container: UIStackView){
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
    
    // Set up text filed view for user input
    func setupTextField(){
        // style
        textField.textColor = UIColor.lightGray
        textField.textAlignment = .center
        textField.font = UIFont(name: "verdana", size: 14.0)
        // close keyboard if user clicks done
        textField.returnKeyType = .done        
    }


}

// Custom textField for picker
class PickerTextField: UITextField, UITextFieldDelegate{
    
    // disable edit
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
    
    // disable cursor
    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    // disable selection
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }

    // disable copy/paste/selectall action
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            return false
        }

        return super.canPerformAction(action, withSender: sender)
    }
    
}


    
    




