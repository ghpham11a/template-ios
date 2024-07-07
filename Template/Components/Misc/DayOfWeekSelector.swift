//
//  DayOfWeekSelector.swift
//  Template
//
//  Created by Anthony Pham on 7/6/24.
//

import SwiftUI

struct DayOfWeekSelector: View {
    
    @Binding var selectedDay: Date
    @Binding var days: [Date]
    var onDaySelected: (Date) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(days, id: \.self) { day in
                    Button(action: {
                        onDaySelected(day)
                    }) {
                        VStack {
                            Text(day.ISO8601Format())
                        }
                    }
                    .background(Color.gray)
                    .frame(width: 50, height: 100)
                }
            }
            .padding()
        }
    }
}
