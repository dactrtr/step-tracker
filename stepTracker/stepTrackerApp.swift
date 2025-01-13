//
//  stepTrackerApp.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 06-08-24.
//

import SwiftUI

@main
struct stepTrackerApp: App {
  
  let hkManager = HealthKitManager()
  
    var body: some Scene {
        WindowGroup {
            DashBoardView()
            .environment(hkManager)
        }
    }
}
