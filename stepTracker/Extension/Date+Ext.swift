//
//  Date+Ext.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 31-08-24.
//

import Foundation

extension Date {
  var weekdayInt: Int{
    Calendar.current.component(.weekday, from: self)
  }
  var weekdayTitle: String{
    self.formatted(.dateTime.weekday(.wide))
  }
}
