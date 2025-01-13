//
//  Array+Ext.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 03-10-24.
//

import Foundation
extension Array where Element == Double {
  var average : Double {
    
    guard !self.isEmpty else { return 0 }
    let total = self.reduce(0, +)
    return total/Double(self.count)
    
  }
}
