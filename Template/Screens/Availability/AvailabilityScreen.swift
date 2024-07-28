//
//  AvailabilityScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/6/24.
//

import SwiftUI

struct Block {
    var id: String
    var dateKey: String
    var startTime: Date
    var endTime: Date
}

struct AvailabilityScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var selectedDay: Date = Date()
    @State var days: [Date] = []
    @State var selectedAvailabilityType: Int = 1
    @State var showAvailabilityTypes: Bool = false
    
    @State var displayedBlocks: [Block] = []
    
    @State var availabilityType1Blocks: [Block] = []
    @State var availabilityType2Blocks: [Block] = []
    @State var availabilityType3Blocks: [Block] = []
    @State var availabilityType4Blocks: [Block] = []
    
    let dateFormatter = DateFormatter()
    
    let availabilityTypes = ["Availability Type 1", "Availability Type 2", "Availability Type 3", "Availability Type 4"]
    
    var body: some View {
        VStack {
            DayOfWeekSelector(days: $days, selectedDay: $selectedDay, currentIndex: 2) { date in
                if dateFormatter.string(from: selectedDay) != dateFormatter.string(from: date) {
                    selectedDay = date
                    displayedBlocks = getBlocksToDisplay(selectedDay: date, selectedAvailabilityType: selectedAvailabilityType)
                }
            }
            
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
                
                ForEach(displayedBlocks, id: \.id) { block in
                    AvailabilityBlock(startTime: block.startTime, endTime: block.endTime)
                }
                
                LoadingButton(title: "Add", isLoading: false, isEnabled: true, action: {
                    addBlock()
                })
            }
        }
        .onAppear {
            days = getDatesInRange().map { getDayOfWeek($0) }
            dateFormatter.dateFormat = "yyyy-MM-dd"
        }
        .sheet(isPresented: $showAvailabilityTypes) {
            VStack{
                ForEach(availabilityTypes, id: \.localized) { block in
                    LoadingButton(title: block, isLoading: false, isEnabled: true, action: {
                        selectedAvailabilityType = Int(block.split(separator: " ")[2]) ?? 0
                        displayedBlocks = getBlocksToDisplay(selectedDay: selectedDay, selectedAvailabilityType: selectedAvailabilityType)
                        showAvailabilityTypes.toggle()
                    })
                }
            }
            .presentationDetents([.fraction(0.5)])
        }
        .padding()
    }
    
    func addBlock() {
        
        let key = dateFormatter.string(from: selectedDay)
        
        guard let start = Date.from("2024-07-01 13:00:00") else { return }
        guard let end = Date.from("2024-07-01 15:00:00") else { return }
        
        switch selectedAvailabilityType {
        case 1:
            availabilityType1Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
        case 2:
            availabilityType2Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
        case 3:
            availabilityType3Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
        case 4:
            availabilityType4Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
        default:
            break
        }
        
        displayedBlocks = getBlocksToDisplay(selectedDay: selectedDay, selectedAvailabilityType: selectedAvailabilityType)
    }
    
    func getBlocksToDisplay(selectedDay: Date, selectedAvailabilityType: Int) -> [Block] {
        
        var key = dateFormatter.string(from: selectedDay)
        
        switch selectedAvailabilityType {
        case 1:
            return availabilityType1Blocks.filter { $0.dateKey == key }
        case 2:
            return availabilityType2Blocks.filter { $0.dateKey == key }
        case 3:
            return availabilityType3Blocks.filter { $0.dateKey == key }
        case 4:
            return availabilityType4Blocks.filter { $0.dateKey == key }
        default:
            break
        }
        
        return []
    }

    func getDayOfWeek(_ dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            // Successfully parsed the date string
            return date
        } else {
            // Failed to parse the date string
            print("Failed to parse date")
            return Date()
        }
    }
    
    func getDatesInRange() -> [String] {
        // Get the current date
        let currentDate = Date()
        
        // Calculate the start and end dates
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: currentDate)!
        let twoWeeksLater = Calendar.current.date(byAdding: .day, value: 14, to: currentDate)!
        
        // Date formatter to display the dates in the desired format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // Initialize the date to the start date
        var date = twoDaysAgo
        
        // Array to hold the formatted date strings
        var dateStrings: [String] = []
        
        // Loop through each date in the range
        while date <= twoWeeksLater {
            // Convert the date to a string
            let dateString = dateFormatter.string(from: date)
            
            // Append the date string to the array
            dateStrings.append(dateString)
            
            // Move to the next date
            date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
        }
        
        
        return dateStrings
    }
}

//#Preview {
//    AvailabilityScreen()
//}

