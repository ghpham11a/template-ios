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
            HStack {
                VStack(alignment: .leading) {
                    Text("Start Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("End Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding(2)
        
    }
}
