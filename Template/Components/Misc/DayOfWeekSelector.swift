//
//  DayOfWeekSelector.swift
//  Template
//
//  Created by Anthony Pham on 7/6/24.
//

import SwiftUI

struct DayOfWeekSelector: View {
    @Binding var days: [Date]
    @Binding var selectedDay: Date
    @State var currentIndex: Int
    var onDaySelected: (Date) -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                // Move back by one day
                if currentIndex > 0 {
                    currentIndex -= 1
                    onDaySelected(days[currentIndex])
                }
            }) {
                Image(systemName: "chevron.left")
                    .font(.title)
            }
            
            Spacer()
            
            Text(dateFormatter.string(from: selectedDay))
                .font(.headline)
            
            Spacer()
            
            Button(action: {
                // Move forward by one day
                if currentIndex < days.count - 1 {
                    currentIndex += 1
                    onDaySelected(days[currentIndex])
                }
            }) {
                Image(systemName: "chevron.right")
                    .font(.title)
            }
        }
        .onAppear {
            if let index = days.firstIndex(of: selectedDay) {
                currentIndex = index
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}
