//
//  Cell.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-25.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
import PromiseKit

class Cell: UITableViewCell {
    
    var placeLabel: UILabel!
    var areaLabel: UILabel!
    var segmentedBar: SegmentedBar!
    var profileGroup: ProfileGroup!
    var tags: [Tag]!
    var container: UIView!
    var descriptionLabel: UILabel!
    var locationIcon: UIImageView!
    var insetView: UIView!
    var periodIcon: UIImageView!
    var timeLabel: UILabel!
    
    func setupInsetView() {
        let v = UIView()
        v.backgroundColor = UIColor.white
        v.layer.cornerRadius = 20
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowRadius = 4
        v.layer.shadowOpacity = 0.2
        v.layer.shadowOffset = CGSize.zero
        self.contentView.addSubview(v)
        self.insetView = v
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10),
            v.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10),
            v.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 10),
            v.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupContainerView() {
        let container = UIView()
        container.backgroundColor = UIColor.clear
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        self.insetView.addSubview(container)
        container.pinTo(self.insetView)
        self.container = container
    }
    
    func setupLocationIcon() {
        let locationIcon = UIImageView(image: UIImage(named: "locationIcon"))
        self.container.addSubview(locationIcon)
        locationIcon.center = CGPoint(x: 30, y: 22)
        locationIcon.frame = locationIcon.frame.integral
        self.locationIcon = locationIcon
    }
    
    func setupPlaceLabel() {
        let l = UILabel()
        l.font = UIFont(name: "ProximaNova-Regular", size: 17)
        l.textAlignment = .left
        l.textColor = #colorLiteral(red: 0.2195796371, green: 0.2196240723, blue: 0.2195768356, alpha: 1)
        container.addSubview(l)
        l.translatesAutoresizingMaskIntoConstraints = false
        //        l.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        self.placeLabel = l
        
        NSLayoutConstraint.activate([
            l.leadingAnchor.constraint(equalTo: self.locationIcon.trailingAnchor, constant: 8),
            l.centerYAnchor.constraint(equalTo: self.locationIcon.centerYAnchor, constant: 1)
        ])
    }
    
    func setupAreaLabel() {
        let l = UILabel()
        l.font = UIFont(name: "ProximaNova-Regular", size: 14)
        l.textColor = #colorLiteral(red: 0.4195591211, green: 0.4196358919, blue: 0.4195542336, alpha: 1)
        l.textAlignment = .left
        self.container.addSubview(l)
        l.translatesAutoresizingMaskIntoConstraints = false
        var constraints = [
            l.leadingAnchor.constraint(equalTo: self.placeLabel.trailingAnchor, constant: 12),
            l.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -30),
            l.bottomAnchor.constraint(equalTo: self.placeLabel.bottomAnchor, constant: -1)
        ]
        
        constraints[1].priority = .defaultLow // so the place label will use its dynamic intrinsic width.
        
        NSLayoutConstraint.activate(constraints)
        self.areaLabel = l
    }
    
    func setupDescriptionLabel() {
        let desc = UILabel()
        desc.font = UIFont(name: "ProximaNova-Regular", size: 14)
        desc.textColor = #colorLiteral(red: 0.4195591211, green: 0.4196358919, blue: 0.4195542336, alpha: 1)
        desc.textAlignment = .left
        desc.addKerning(0.2)
        desc.addLineSpacing(2)
        desc.numberOfLines = 2
        self.container.addSubview(desc)
        //        desc.backgroundColor = UIColor.blue.withAlphaComponent(0.1)
        
        desc.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            desc.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            desc.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            desc.topAnchor.constraint(equalTo: self.placeLabel.bottomAnchor, constant: 33),
            desc.heightAnchor.constraint(equalToConstant: 40)
        ])
        self.descriptionLabel = desc
    }
    
    func setupPeriodIcon() {
        let period = UIImageView(image: UIImage(named: "PM"))
        self.container.addSubview(period)
        period.translatesAutoresizingMaskIntoConstraints = false
        //        period.backgroundColor = UIColor.green.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            period.intrinsicWidthConstraint,
            period.intrinsicHeightConstraint,
            period.trailingAnchor.constraint(equalTo: self.container.trailingAnchor, constant: -15),
            period.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -15)
        ])
        self.periodIcon = period
    }
    
    func setupTimeLabel() {
        let time = UILabel()
        time.font = UIFont(name: "ProximaNova-Regular", size: 21)
        time.textColor = #colorLiteral(red: 0.2200894952, green: 0.4641377926, blue: 0.8669697642, alpha: 1)
        time.text = "3"
        self.container.addSubview(time)
        time.translatesAutoresizingMaskIntoConstraints = false
        //        time.backgroundColor = UIColor.purple.withAlphaComponent(0.2)
        
        NSLayoutConstraint.activate([
            time.bottomAnchor.constraint(equalTo: self.periodIcon.bottomAnchor, constant: 7),
            time.trailingAnchor.constraint(equalTo: self.periodIcon.leadingAnchor, constant: -4)
        ])
        self.timeLabel = time
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
        
        // Create an inset view that has the shadow, and a container view that has all the content.
        // The container view will be clipped to bounds to crop the segmented bar.
        // If you clip to bounds on a view that has a shadow, it will be cut out.
        // So we clip the container view instead.
        
        self.setupInsetView()
        self.setupContainerView()
        self.setupLocationIcon()
        self.setupPlaceLabel()
        self.setupAreaLabel()
        self.setupDescriptionLabel()
        self.setupPeriodIcon()
        self.setupTimeLabel()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createNewProfileGroup(names: [String], maxCount: Int) {
        
        let g = ProfileGroup(profileNames: names, max: maxCount)
        self.container.addSubview(g)
        g.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            g.intrinsicWidthConstraint,
            g.intrinsicHeightConstraint,
            g.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -10),
            g.leadingAnchor.constraint(equalTo: self.container.leadingAnchor, constant: 10)
        ])
        self.profileGroup = g
    }
    
    func createNewSegmentedBar(currentCount: Int, maxCount: Int) {
        
        let b = SegmentedBar(currentCount: currentCount, maxCount: maxCount)
        container.addSubview(b)
        b.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            b.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            b.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            b.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            b.heightAnchor.constraint(equalToConstant: 5)
        ])
        self.segmentedBar = b
        
        
    }
    
    func createNewTagsFrom(_ tagStrings: [String]) {
        
        var tags: [Tag] = []
        for s in tagStrings {
            let tag = Tag(string: s)
            tags.append(tag)
        }
        
        let y: CGFloat = 40
        var x: CGFloat = 14
        
        for each in tags {
            each.frame.origin.y = y
            each.frame.origin.x = x
            x += each.bounds.width + 10
            self.container.addSubview(each)
        }
        self.tags = tags
        
    }
    
    func configureWith(_ e: Event) {
        self.placeLabel.text = e.place
        self.areaLabel.text = e.area
        self.descriptionLabel.text = e.description
        
        if self.segmentedBar != nil {
            self.segmentedBar.removeFromSuperview()
        }
        self.createNewSegmentedBar(currentCount: e.people.count, maxCount: e.maxOccupancy)
        
        if self.profileGroup != nil {
            self.profileGroup.removeFromSuperview()
        }
        self.createNewProfileGroup(names: e.people, maxCount: e.maxOccupancy)
        
        if self.tags != nil {
            self.tags!.map { $0.removeFromSuperview() }
        }
        self.createNewTagsFrom(e.tags)
        
        let date = Date(timeIntervalSince1970: e.date)
        let calendar = Calendar.current

        let hour = calendar.component(.hour, from: date) - 12
        let minutes = calendar.component(.minute, from: date)
        
        if minutes == 0 {
            self.timeLabel.text = "\(hour)"
        } else {
            self.timeLabel.text = "\(hour):\(minutes)"
        }
        
    }
    
}

extension Cell: EventDelegate {
    func didJoin(event: Event) {
        // Update the segmented bar and profile group components
        print("did join")
        
        self.segmentedBar.increment()
        self.profileGroup.addProfile(withName: User.current.name)
        
        firstly {
            🎟Join(eventID: event.id!, yourID: User.current.name).run()
        }.done { _ in
            print("Join request successful")
        }.catch { error in
            print("Join request failed:")
            print(error)
        }
    }
    
    func didLeave(event: Event, index: Int) {
        // Update the segmented bar and profile group components
        print("did leave")
        
        self.segmentedBar.decrement()
        self.profileGroup.removeProfile(atIndex: index)
        
        firstly {
            🎟Leave(eventID: event.id!, yourID: User.current.name).run()
        }.done { _ in
            print("Leave request successful")
        }.catch { error in
            print("Leave request failed:")
            print(error)
        }
    }
    
    
}
