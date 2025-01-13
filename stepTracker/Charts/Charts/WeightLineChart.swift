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
    @State private var selectedDay: Date?
    
    var chartData: [DateValueChartData]
    
    var selectedData: DateValueChartData? {
        ChartHelper.parseSelectedData(for: chartData, in: rawSelectedDate)
    }
    
    var minValue: Double{
        chartData.map { $0.value }.min() ?? 0
    }
    
    var average : Double{
        chartData.map { $0.value }.average
    }
    
    var body: some View {
        
        ChartContainer(chartType: .weightLine(average: average)) {
            
            Chart{
                
                if let selectedData{
                    
                    ChartAnnotationView(data: selectedData, context: .weight)
                    
                }
                if !chartData.isEmpty {
                    RuleMark(y: .value("Goal", 70)) // goal hardcoded
                        .lineStyle(.init(lineWidth: 1, dash: [5]))
                        .foregroundStyle(.mint)
                    .accessibilityHidden(true)        }
                
                ForEach(chartData) { weight in
                    
                    Plot {
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
                    .accessibilityLabel(weight.date.accessibilityDate)
                    .accessibilityValue("\(weight.value.formatted(.number.precision(.fractionLength(1))))) pounds")
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
            .overlay{
                if chartData.isEmpty{
                    
                    ChartEmptyView(systemImageName: "chart.xyaxis.line", title: "No Data", description: "There is no weight data from the Health App")
                }
            }
        }
        .sensoryFeedback(.selection, trigger: rawSelectedDate)
        .onChange(of: rawSelectedDate) { oldValue, newValue in
            if oldValue?.weekdayInt != newValue?.weekdayInt {
                selectedDay = newValue
            }
        }
    }
    
}

#Preview {
    WeightLineChart(chartData: ChartHelper.convert(data:MockData.weights))
}
