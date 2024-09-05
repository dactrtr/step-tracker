//
//  WeightLineChart.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 04-09-24.
//

import SwiftUI
import Charts

struct WeightLineChart: View {
  
  @State private var rawSelectedDate : Date?
  
  var selectedHealthMetric: HealthMetric? {
    guard let rawSelectedDate else { return nil }
    return chartData.first {
      Calendar.current.isDate(rawSelectedDate, inSameDayAs: $0.date)
    }
  }
  
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
        
        if let selectedHealthMetric{
          RuleMark(x: .value("Selected Metric", selectedHealthMetric.date, unit: .day))
            .foregroundStyle(Color.secondary.opacity(0.3))
            .annotation(position: .top,
                        spacing: 0,
                        overflowResolution: .init(x: .fit(to: .chart), y: .disabled)) {
              annotationView
            }
        }
        
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
      .chartXSelection(value: $rawSelectedDate)
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
  var annotationView: some View {
    VStack(alignment: .leading){
      Text(selectedHealthMetric?.date ?? .now, format: .dateTime.weekday(.abbreviated).month(.abbreviated))
        .font(.footnote.bold())
        .foregroundStyle(.secondary)
      
      Text(selectedHealthMetric?.value ?? 0, format: .number.precision(.fractionLength(2)))
        .fontWeight(.heavy)
        .foregroundStyle(Color.indigo)
    }
    .padding(12)
    .background(
      RoundedRectangle(cornerRadius: 4)
        .fill(Color(.secondarySystemBackground))
        .shadow(color: .secondary.opacity(0.3), radius: 2, x: 2, y: 2)
    )
  }
}

#Preview {
  WeightLineChart(selectedStat: .weight, chartData: MockData.weights)
}
