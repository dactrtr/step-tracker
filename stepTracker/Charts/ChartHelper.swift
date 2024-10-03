//
//  ChartHelper.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 24-09-24.
//

import Foundation

struct ChartHelper{
  static func  convert(data: [HealthMetric]) -> [DateValueChartData]{
    data.map { .init(date: $0.date, value: $0.value)}
  }
  
  static func parseSelectedData (for data:[DateValueChartData], in selectedDate: Date?) -> DateValueChartData? {
    guard let  selectedDate else { return nil }
    return data.first {
      Calendar.current.isDate(selectedDate, inSameDayAs: $0.date)
    }
  }
  
}
