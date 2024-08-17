//
//  ContentView.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 06-08-24.
//

import SwiftUI
import Charts

enum HealthMetricContext : CaseIterable, Identifiable{
  case steps, weight
  var id: Self { self }
  var title: String{
    switch self{
    case .steps:
      return "Steps"
    case .weight:
      return "Weight"
    }
  }
}

struct DashBoardView: View {
  
  @Environment(HealthKitManager.self) private var hkManager
  
  @AppStorage("hasSeenPermissionPriming") private var hasSeenPermissionPriming = false
  @State private var isShowingPermissionPrimingSheet = false
  
  @State private var selectedStat: HealthMetricContext = .steps
  
  var isSteps : Bool {selectedStat == .steps}
  
  var body: some View {
    NavigationStack{
      ScrollView{
        VStack(spacing: 20){
          
          Picker("Selected Stat", selection: $selectedStat){
            ForEach(HealthMetricContext.allCases) {
              Text($0.title)
            }
          }
          .pickerStyle(.segmented)
          
          StepBarChart(selectedStat: selectedStat, chartData: hkManager.stepData)
          
          VStack(alignment:.leading) {
            VStack(alignment:.leading){
              Label("Averages", systemImage: "calendar")
                .font(.title3.bold())
                .foregroundColor(.pink)
              Text("last 28 days")
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            .padding(.bottom)
            RoundedRectangle(cornerRadius: 12)
              .foregroundStyle(.secondary)
              .frame(height: 240)
          }
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
        }
      }
      .padding()
      .task{
        await hkManager.fetchStepCount()
        isShowingPermissionPrimingSheet = !hasSeenPermissionPriming
      }
      .navigationTitle("Dashboard")
      .navigationDestination(for: HealthMetricContext.self) { metric in
        HealthDataListView(metric: metric)
      }
      .sheet(isPresented: $isShowingPermissionPrimingSheet, onDismiss: {
        // fetch health data
      }, content: {
        HealthKitPermissionPrimingView(hasSeen: $hasSeenPermissionPriming)
      })
    }
    .tint(isSteps ? .pink : .indigo)
  }
  
  
}

#Preview {
  DashBoardView()
    .environment(HealthKitManager())
}
