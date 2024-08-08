//
//  HealthKitManager.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 08-08-24.
//

import Foundation
import HealthKit
import Observation

@Observable class HealthKitManager{
  
  let store = HKHealthStore()
  
  let types: Set = [HKQuantityType(.stepCount), HKQuantityType(.bodyMass)]
}
