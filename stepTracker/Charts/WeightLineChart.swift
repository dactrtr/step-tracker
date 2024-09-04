//
//  WeightLineChart.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 04-09-24.
//

import SwiftUI
import Charts

struct WeightLineChart: View {
  var minValue: Double{
    chartData.map { $0.value }.min() ?? 0
  }
  
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
        
        RuleMark(y: .value("Goal", 155))
          .lineStyle(.init(lineWidth: 1, dash: [5]))
          .foregroundStyle(.mint)
        
        ForEach(chartData) { weight in
          AreaMark(
            x: .value("day", weight.date, unit: .day), 
            yStart: .value("Value", weight.value),
            yEnd: .value("Min Value", minValue))
          .foregroundStyle(Gradient(colors:[.indigo.opacity(0.5),.clear]))
          .interpolationMethod(.catmullRom)
          
          LineMark(
            x: .value("day",weight.date, unit: .day),
            y:.value("value", weight.value)
          )
          .foregroundStyle(.indigo)
          .interpolationMethod(.catmullRom)
          .symbol(.circle)
         
        }
      }
      
      .frame(height:150)
      .chartYScale(domain: .automatic(includesZero: false))
      .chartXAxis{
        AxisMarks{
          AxisValueLabel(format: .dateTime.month(.defaultDigits).day())
        }
      }
      .chartYAxis{
        AxisMarks{ value in
          AxisGridLine()
            .foregroundStyle(Color.secondary.opacity(0.3))
          AxisValueLabel()
        }
      }
      
    }
    .padding()
    .background(
      RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
  }
}

#Preview {
  WeightLineChart(selectedStat: .weight, chartData: MockData.weights)
}
