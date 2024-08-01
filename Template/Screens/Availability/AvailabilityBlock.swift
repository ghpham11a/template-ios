//
//  AvailabilityBlock.swift
//  Template
//
//  Created by Anthony Pham on 7/21/24.
//

import SwiftUI

struct AvailabilityBlock: View {
    
    @State var id: String
    @State var startTime = ""
    @State var endTime = ""
    var onRemove: () -> Void
    var onStartTapped: (String) -> Void
    var onEndTapped: (String) -> Void
    
    var body: some View {
        HStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Start Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(action: {
                        onStartTapped(id)
                    }) {
                        Text(startTime)
                    }
//                    DatePicker("Start Time", selection: $startTime, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                        .onChange(of: startTime) { oldValue, newValue in
//                            // startTime = roundToNearestQuarterHour(date: newValue)
//                            onStartDateChange(id, newValue)
//                        }
                    
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("End Time")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    Button(action: {
                        onEndTapped(id)
                    }) {
                        Text(endTime)
                    }
//                    DatePicker("End Time", selection: $endTime, displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                        .onChange(of: endTime) { oldValue, newValue in
//                            // startTime = roundToNearestQuarterHour(date: newValue)
//                            onEndDateChange(id, newValue)
//                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(radius: 2)
            .padding(2)
            
            Button(action: {
                onRemove()
            }) {
                Text("X")
            }
        }
    }

    // Function to round date to the nearest 15-minute interval
    func roundToNearestQuarterHour(date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let minute = (components.minute ?? 0) / 15 * 15
        return calendar.date(bySetting: .minute, value: minute, of: date) ?? date
    }
}
