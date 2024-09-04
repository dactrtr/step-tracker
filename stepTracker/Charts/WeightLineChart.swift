//
//  WeightLineChart.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 04-09-24.
//

import SwiftUI
import Charts

struct WeightLineChart: View {
  var selectedStat: HealthMetricContext
  var chartData: [HealthMetric]
  var body: some View {
    VStack {
      NavigationLink(value: selectedStat){
        HStack{
          VStack(alignment:.leading){
            Label("Weight", systemImage: "figure")
              .font(.title3.bold())
              .foregroundColor(.indigo)
            Text("Avg: 180 lbs")
              .font(.caption)
            
          }
          
          Spacer()
          
          Image(systemName: "chevron.right")
        }
      }
      .foregroundStyle(.secondary)
      .padding(.bottom)
      Chart{
        ForEach(chartData) { weight in
          AreaMark(
            x: .value("day",weight.date, unit: .day),
            y:.value("value", weight.value)
          )
          .foregroundStyle(Gradient(colors:[.blue.opacity(0.5),.clear]))
          LineMark(
            x: .value("day",weight.date, unit: .day),
            y:.value("value", weight.value)
          )
        }
      }
      
      .frame(height:150)
      
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
  }
}

#Preview {
  WeightLineChart(selectedStat: .weight, chartData: MockData.weights)
}
