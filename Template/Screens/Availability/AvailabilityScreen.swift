//
//  AvailabilityScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/6/24.
//

import SwiftUI

struct AvailabilityScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var selectedDay: Date = Date()
    @State var days: [Date] = []
    var body: some View {
        ScrollView {
            Text("AvailabilityScreen")
            DayOfWeekSelector(selectedDay: $selectedDay, days: $days) { date in
                selectedDay = date
            }
            Text(selectedDay.description)
        }
        .onAppear {
            days = [getDayOfWeek("2024-07-01"), getDayOfWeek("2024-07-02"), getDayOfWeek("2024-07-03"), getDayOfWeek("2024-07-04")]
        }
    }

    func getDayOfWeek(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            // Successfully parsed the date string
            print(date)
            return date
        } else {
            // Failed to parse the date string
            print("Failed to parse date")
            return Date()
        }
    }
}

//#Preview {
//    AvailabilityScreen()
//}

