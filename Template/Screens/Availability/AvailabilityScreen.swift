//
//  AvailabilityScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/6/24.
//

import SwiftUI

struct Block {
    var startTime: Date
    var endTime: Date
}

struct AvailabilityScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var selectedDay: Date = Date()
    @State var days: [Date] = []
    @State var selectedAvailabilityType: Int = -1
    @State var showAvailabilityTypes: Bool = false
    
    @State var blocks: [Block] = []
    
    var body: some View {
        VStack {
            Text("AvailabilityScreen")
            DayOfWeekSelector(selectedDay: $selectedDay, days: $days) { date in
                selectedDay = date
            }
            Text(selectedDay.description)
            
            Button(action: {
                self.showAvailabilityTypes = true
            }) {
                HStack {
                    Text("\(selectedAvailabilityType)")
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            ScrollView {
                ForEach(blocks, id: \.startTime) { block in
                    AvailabilityBlock(startTime: block.startTime, endTime: block.endTime)
                }
                Button(action: {
                    if let start = Date.from("2024-07-01 13:00:00"), let end = Date.from("2024-07-01 15:00:00") {
                        blocks.append(Block(startTime: start, endTime: end))
                    }
                }) {
                    Text("Add")
                }
            }
        }
        .onAppear {
            days = [getDayOfWeek("2024-07-01"), getDayOfWeek("2024-07-02"), getDayOfWeek("2024-07-03"), getDayOfWeek("2024-07-04")]
        }
        .sheet(isPresented: $showAvailabilityTypes) {
            VStack{
                Button(action: {
                    selectedAvailabilityType = 1
                    showAvailabilityTypes.toggle()
                }) {
                    Text("Availability Type 1")
                }
                Button(action: {
                    selectedAvailabilityType = 2
                    showAvailabilityTypes.toggle()
                }) {
                    Text("Availability Type 2")
                }
                Button(action: {
                    selectedAvailabilityType = 3
                    showAvailabilityTypes.toggle()
                }) {
                    Text("Availability Typ 3")
                }
                Button(action: {
                    selectedAvailabilityType = 4
                    showAvailabilityTypes.toggle()
                }) {
                    Text("Availability Typ 4")
                }
            }
            .presentationDetents([.fraction(0.5)])
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

