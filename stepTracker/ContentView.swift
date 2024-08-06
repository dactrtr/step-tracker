//
//  ContentView.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 06-08-24.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationStack{
      ScrollView{
        VStack(spacing: 20){
          VStack {
            HStack{
              VStack(alignment:.leading){
                Label("Stepts", systemImage: "figure.walk")
                  .font(.title3.bold())
                  .foregroundColor(.pink)
                Text("Avg: 18k steps")
                  .font(.caption)
                  .foregroundStyle(.secondary)
              }
              Spacer()
              Image(systemName: "chevron.right")
                .foregroundStyle(.secondary)
            }
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
    }
  }
}

#Preview {
  ContentView()
}
