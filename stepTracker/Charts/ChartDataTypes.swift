//
//  ChartDataTypes.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 31-08-24.
//

import Foundation

struct DateValueChartData: Identifiable, Equatable {
  let id = UUID()
  let date: Date
  let value: Double
}
