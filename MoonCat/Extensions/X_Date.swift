//
//  X_Date.swift
//  MoonCat
//
//  Created by Yingsi Chu on 2019-12-01.
//  Copyright © 2019 Bolusaur. All rights reserved.
//

import UIKit

extension Date {

    /**
     converts date to sting using today as refference
     */
    func toString() -> String {
        let now = Calendar.current
        if now.isDateInToday(self) {
            return "Today"
        }
        else if now.isDateInTomorrow(self) {
            return "Tomorrow"
        }
        else {
            let startOfNow = now.startOfDay(for: Date())
            let startOfDate = now.startOfDay(for: self)
            let components = now.dateComponents([.day], from: startOfNow, to: startOfDate)
            let day = components.day!
            return "In \(day) days"
        }
    }
    /**
     initialize a date by time variables provided*/
    init(year: Int, month: Int, day: Int, hour: Int, min: Int) {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = min

        let calendar = Calendar.current
        let result = calendar.date(from: dateComponents)!
        self.init(timeInterval:0, since: result)
    }
}
