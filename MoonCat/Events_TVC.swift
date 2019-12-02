//
//  Events_TVC.swift
//  MoonCat
//
//  Created by Muji Paracha on 2019-11-25.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit
//
//        [Event(place: "Robarts Library",
//              area: "Saint George Street",
//              description: "Some description about the event goes here, who knows, it can be whatever you want.",
//              date: nil,
//              maxOccupancy: 5,
//              people: ["profile_2"],
//              tags: ["Study", "Csc209"])
//        ]

class Events_TVC: UITableViewController {
    
    var model = [[Event]]()
    var headers = [String]()
    
    
    func intro() {
        self.view.center.y += 100
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 3, options: [], animations: {
            self.view.alpha = 1
            self.view.center.y -= 100
        }, completion: nil)
        
    }
    
    
    func process(events: [Event]) {
        // Separate the events by day
        // Have a [[Event]] as the model, so you can index in on it by the different days (should still be ordered)
        // Have a [String] being the formatted day strings for use in header views.
        
        // Date is well, a Date.
        // We need to generate the YYYYMMdd for each date, and use that as the group.
        // Do this for all events, collecting them into the groups, maintaining order.
        // Then we need to generate a day string for each YYYYMMdd.
        // This will depend on the current date, ex. Today, Tomorrow, Monday 12. For now leave out the month; it's obvious.
        
        for each in events {
            let slotKey = Date(timeIntervalSince1970: each.date).toString()
            if let i = self.headers.firstIndex(of: slotKey) {
                // Put the event there
                self.model[i].append(each)
            } else {
                // This is a new slot key.
                // Append it to headers.
                // Append a new empty array in the model
                // Put the event in the last index
                
                self.headers.append(slotKey)
                self.model.append([Event]())
                self.model[self.model.count - 1].append(each)
            }
        }
        
    }
    
    init(events: [Event]) {
        super.init(style: .grouped)
        self.process(events: events)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "Header")
        self.tableView.register(Cell.self, forCellReuseIdentifier: "Cell")
        self.tableView.rowHeight = 200
        self.tableView.separatorColor = UIColor.clear
        self.tableView.backgroundColor = UIColor.white
        
        self.tableView.contentInset = UIEdgeInsets(top: 56, left: 0, bottom: 70, right: 0)
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(sender:)))
        doubleTap.numberOfTapsRequired = 2
        self.tableView.addGestureRecognizer(doubleTap)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.headers.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.model[section].count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! Cell
        let event = self.model[indexPath.section][indexPath.row]
        cell.configureWith(event)
        event.delegate = cell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let event = self.model[indexPath.section][indexPath.row]
        event.delegate = nil
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as! Header
        header.label.text = self.headers[section]
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    /**
     Has the user join or leave
     */
    @objc func handleDoubleTap(sender: UITapGestureRecognizer) {
        
        let loc = sender.location(in: sender.view)
        guard let indexPath = self.tableView.indexPathForRow(at: loc) else { return }
        let event = self.model[indexPath.section][indexPath.row]
        event.joinOrLeave()
        
        
    }

    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath) as! Cell
//        cell.segmentedBar.increment()
//    }

}
