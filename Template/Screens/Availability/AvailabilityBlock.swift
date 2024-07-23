//
//  AvailabilityBlock.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import SwiftUI

struct AvailabilityBlock: View {
    
    @State var startTime = Date()
    @State var endTime = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                VStack(alignment: .leading) {
                    Text("Start Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("End Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            .padding(.top, 8)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
