//
//  ChartContainer.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 18-09-24.
//

import SwiftUI

enum ChartType{
  case stepBar(average : Int)
  case stepWeekdaysPie
  case weightLine(average: Double)
  case weightDiffBar
}

struct ChartContainer<Content: View>: View {
  
  let chartType : ChartType
  
  @ViewBuilder var content: () -> Content
  
  var body: some View {
    VStack(alignment: .leading) {
      if isNav {
        navigationLinkView
        
      } else {
        titleView
          .foregroundStyle(.secondary)
          .padding(.bottom, 12)
      }
      content()
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
  }
  
  var navigationLinkView: some View {
    NavigationLink(value: context){
      HStack{
        titleView
        
        Spacer()
        
        Image(systemName: "chevron.right")
      }
    }
    
  }
  
  var titleView: some View {
    VStack(alignment:.leading){
      Label(title, systemImage: symbol)
        .font(.title3.bold())
        .foregroundColor(context == .steps ? .pink : .indigo)
      Text(subtitle)
        .font(.caption)
      
    }
  }
  
  var isNav: Bool {
    switch chartType {
    case .stepBar(_), .weightLine(_):
      return true
    case .stepWeekdaysPie, .weightDiffBar:
      return false
    }
  }
  
  var context: HealthMetricContext{
    switch chartType {
    case .stepBar(_), .stepWeekdaysPie:
        .steps
    case .weightLine(_), .weightDiffBar:
        .weight
    }
  }
  
  var title : String {
    switch chartType {
    case .stepBar(_):
      "Steps"
    case .stepWeekdaysPie:
      "Averages"
    case .weightLine(_):
      "Weight"
    case .weightDiffBar:
      "Averages Weight Change"
    }
  }
  
  var symbol : String {
    switch chartType {
    case .stepBar(_):
      "figure.walk"
    case .stepWeekdaysPie:
      "calendar"
    case .weightLine(_), .weightDiffBar:
      "figure"
    }
  }
  
  var subtitle : String {
    switch chartType {
    case .stepBar(let average):
      "Avg: \(average.formatted()) steps"
    case .stepWeekdaysPie:
      "Last 28 days "
    case .weightLine(let average):
      "Avg: \(average.formatted(.number.precision(.fractionLength(1)))) lbs"
    case .weightDiffBar:
      "Per Weekday (last 28 days)"
    }
  }
  
}

#Preview {
  ChartContainer(chartType: .stepWeekdaysPie) {
    Text("Chart goes here")
      .frame(minHeight: 150)
  }
}
