//
//  ContentView.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 06-08-24.
//

import SwiftUI
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

struct ContentView: View {
  @State private var selectedStat: HealthMetricContext = .steps
  var isSteps : Bool {selectedStat == .steps}
  var body: some View {
    NavigationStack{
      ScrollView{
        VStack(spacing: 20){
          
          Picker("Selected Stat", selection: $selectedStat){
            ForEach(HealthMetricContext.allCases) { metric in
              Text(metric.title)
            }
          }
          .pickerStyle(.segmented)
          
          VStack {
            NavigationLink(value: selectedStat){
              HStack{
                VStack(alignment:.leading){
                  Label("Stepts", systemImage: "figure.walk")
                    .font(.title3.bold())
                    .foregroundColor(.pink)
                  Text("Avg: 18k steps")
                    .font(.caption)
                  
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
              }
            }
            .foregroundStyle(.secondary)
            .padding(.bottom)
            RoundedRectangle(cornerRadius: 12)
              .foregroundStyle(.secondary)
              .frame(height: 150)
          }
          .padding()
          .background(
            RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
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
      .navigationTitle("Dashboard")
      .navigationDestination(for: HealthMetricContext.self) { metric in
        Text(metric.title)
      }
    }
    .tint(isSteps ? .pink : .indigo)
  }
}

#Preview {
  ContentView()
}
