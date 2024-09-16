//
//  ChartEmptyView.swift
//  stepTracker
//
//  Created by Sebastian Zuniga on 16-09-24.
//

import SwiftUI

struct ChartEmptyView: View {
  let systemImageName : String
  let title: String
  let description: String
    var body: some View {
      ContentUnavailableView {
        
        Image(systemName: systemImageName)
          .resizable()
          .frame(width: 32, height: 32)
          .foregroundStyle(.secondary)
          .padding(.bottom, 8)
        
        
        Text(title)
          .font(.callout.bold())
        
        Text(description)
          .font(.footnote)
      }
      .foregroundStyle(.secondary)
      .offset(y: -12)
    }
}

#Preview {
  ChartEmptyView(systemImageName: "cross", title: "A", description: "b")
}
