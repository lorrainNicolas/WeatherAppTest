//
//  DateFormatter+Weather.swift
//  WeatherAppTest
//
//  Created by Nicolas Lorrain on 26/10/2019.
//  Copyright © 2019 Nicolas Lorrain. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var weatherJsonFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter
    }

    static var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter
    }
}

extension Date {
    func getDay() -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: self)
        return calendar.date(from: dateComponents) ?? Date()
    }
}
