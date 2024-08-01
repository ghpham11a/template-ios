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
    @State var showTimes: Bool = false
    
    @State var displayedBlocks: [Block] = []
    
    @State var availabilityType1Blocks: [Block] = []
    @State var availabilityType2Blocks: [Block] = []
    @State var availabilityType3Blocks: [Block] = []
    @State var availabilityType4Blocks: [Block] = []
    
    @State var isLoading: Bool = false
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    @State var displayedTimes = [String]()
    
    @State var selectedId = ""
    @State var selectedType = ""

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
                    AvailabilityBlock(
                        id: block.id,
                        startTime: timeFormatter.string(from: block.startTime),
                        endTime: timeFormatter.string(from: block.endTime),
                        onRemove: {
                            deleteBlock(block: block)
                        }, 
                        onStartTapped: { id in
                            selectedId = id
                            selectedType = "start"
                            tapStart(id: id)
                        },
                        onEndTapped: { id in
                            selectedId = id
                            selectedType = "end"
                            tapEnd(id: id)
                        }
                    )
                }
                
                LoadingButton(title: "Add", isLoading: false, isEnabled: true, action: {
                    addBlock()
                })
            }
            
            Spacer()
            
            LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: true, action: {
                Task {
                    let response = await updateAvailability()
                    if response {
                        path.removeLast()
                    }
                }
            })
        }
        .onAppear {
            days = getDatesInRange().map { getDayOfWeek($0) }
            
            dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            timeFormatter.dateFormat = "HH:mm"
            
            setupBlocks()
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
        .sheet(isPresented: $showTimes) {
            ScrollView {
                ForEach(displayedTimes, id: \.localized) { time in
                    Button(action: {
                        udpateBlock(time: time)
                    }) {
                        Text(time)
                    }
                    .padding()
                    
                    Divider()
                }
            }
            .padding()
            .presentationDetents([.fraction(0.5)])
        }
        .padding()
    }
    
    func tapStart(id: String) {
        
        showTimes.toggle()
        
        let key = dateFormatter.string(from: selectedDay)
        var typeBlocks = [Block]()
        
        switch selectedAvailabilityType {
        case 1:
            typeBlocks = availabilityType1Blocks.filter { $0.dateKey == key }
        case 2:
            typeBlocks = availabilityType2Blocks.filter { $0.dateKey == key }
        case 3:
            typeBlocks = availabilityType3Blocks.filter { $0.dateKey == key }
        case 4:
            typeBlocks = availabilityType4Blocks.filter { $0.dateKey == key }
        default:
            break
        }
        
        guard let blockIndex = typeBlocks.firstIndex(where: { $0.id == id }) else { return }
        
        var timeRange = [String]()
        
        if typeBlocks.count == 1 || blockIndex == (typeBlocks.count - 1) {
            let endTime = timeFormatter.string(from: typeBlocks[blockIndex].endTime)
            timeRange = createRange(end: endTime)
        } else if typeBlocks.count == 2 && blockIndex == 0 {
            let endTime = timeFormatter.string(from: typeBlocks[blockIndex].endTime)
            timeRange = createRange(end: endTime)
        } else if typeBlocks.count == 2 && blockIndex == 1 {
            let startTime = timeFormatter.string(from: typeBlocks[0].endTime)
            let endTime = timeFormatter.string(from: typeBlocks[blockIndex].endTime)
            timeRange = createRange(start: startTime, end: endTime)
        } else {
            let startTime = timeFormatter.string(from: typeBlocks[blockIndex - 1].endTime)
            let endTime = timeFormatter.string(from: typeBlocks[blockIndex].endTime)
            timeRange = createRange(start: startTime, end: endTime)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.displayedTimes = timeRange
        }
    }
    
    func tapEnd(id: String) {
        
        showTimes.toggle()
        
        let key = dateFormatter.string(from: selectedDay)
        var typeBlocks = [Block]()
        switch selectedAvailabilityType {
        case 1:
            typeBlocks = availabilityType1Blocks.filter { $0.dateKey == key }
        case 2:
            typeBlocks = availabilityType2Blocks.filter { $0.dateKey == key }
        case 3:
            typeBlocks = availabilityType3Blocks.filter { $0.dateKey == key }
        case 4:
            typeBlocks = availabilityType4Blocks.filter { $0.dateKey == key }
        default:
            break
        }
        
        guard let blockIndex = typeBlocks.firstIndex(where: { $0.id == id }) else { return }
        
        var timeRange = [String]()
        
        if typeBlocks.count == 1 || blockIndex == (typeBlocks.count - 1) {
            let startTime = timeFormatter.string(from: typeBlocks[blockIndex].startTime)
            timeRange = createRange(start: startTime)
        } else if typeBlocks.count == 2 && blockIndex == 0 {
            let startTime = timeFormatter.string(from: typeBlocks[blockIndex].startTime)
            let endTime = timeFormatter.string(from: typeBlocks[1].startTime)
            timeRange = createRange(start: startTime, end: endTime)
        } else if typeBlocks.count == 2 && blockIndex == 1 {
            let startTime = timeFormatter.string(from: typeBlocks[blockIndex].startTime)
            timeRange = createRange(start: startTime)
        } else {
            let startTime = timeFormatter.string(from: typeBlocks[blockIndex].startTime)
            let endTime = timeFormatter.string(from: typeBlocks[blockIndex + 1].startTime)
            timeRange = createRange(start: startTime, end: endTime)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.displayedTimes = timeRange
        }
    }
    
    func createRange(start: String = "00:00", end: String = "23:45") -> [String] {
        
        let key = dateFormatter.string(from: selectedDay)
        
        let selectedDay = Date() // Replace with actual selected day
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "yyyy-MM-dd" // Adjust format as needed
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        
        let dateTimeFormatter = DateFormatter()
        dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        guard let startTime = dateTimeFormatter.date(from: "\(key) \(start)"),
              let endTime = dateTimeFormatter.date(from: "\(key) \(end)") else {
            return []
        }
        
        var currentTime = startTime
        var timeRange = [String]()
        
        while currentTime <= endTime {
            timeRange.append(timeFormatter.string(from: currentTime))
            currentTime = Calendar.current.date(byAdding: .minute, value: 15, to: currentTime)!
        }
        
        return timeRange
    }
    
    func udpateBlock(time: String) {
        
        let key = dateFormatter.string(from: selectedDay)
        
        switch selectedAvailabilityType {
        case 1:
            if let index = availabilityType1Blocks.firstIndex(where: { $0.id == selectedId }) {
                if selectedType == "start" {
                    availabilityType1Blocks[index].startTime = dateTimeFormatter.date(from: "\(key) \(time)") ?? Date()
                }
                if selectedType == "end" {
                    availabilityType1Blocks[index].endTime = dateTimeFormatter.date(from: "\(key) \(time)") ?? Date()
                }
            }
        default:
            break
        }
        
        displayedBlocks = []
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.displayedBlocks = self.getBlocksToDisplay(selectedDay: self.selectedDay, selectedAvailabilityType: self.selectedAvailabilityType)
            self.showTimes.toggle()
        }
    }
    
    func _udpateBlock(id: String, type: String, date: Date) {
        
        switch selectedAvailabilityType {
        case 1:
            if let index = availabilityType1Blocks.firstIndex(where: { $0.id == id }) {
                if type == "start" {
                    availabilityType1Blocks[index].startTime = date
                }
                if type == "end" {
                    availabilityType1Blocks[index].endTime = date
                }
            }
        case 2:
            if let index = availabilityType2Blocks.firstIndex(where: { $0.id == id }) {
                if type == "start" {
                    availabilityType2Blocks[index].startTime = date
                }
                if type == "end" {
                    availabilityType2Blocks[index].endTime = date
                }
            }
        case 3:
            if let index = availabilityType3Blocks.firstIndex(where: { $0.id == id }) {
                if type == "start" {
                    availabilityType3Blocks[index].startTime = date
                }
                if type == "end" {
                    availabilityType3Blocks[index].endTime = date
                }
            }
        case 4:
            if let index = availabilityType4Blocks.firstIndex(where: { $0.id == id }) {
                if type == "start" {
                    availabilityType4Blocks[index].startTime = date
                }
                if type == "end" {
                    availabilityType4Blocks[index].endTime = date
                }
            }
        default:
            break
        }
        
        displayedBlocks = getBlocksToDisplay(selectedDay: selectedDay, selectedAvailabilityType: selectedAvailabilityType)
    }
    
    
    func setupBlocks() {
        guard let user = UserRepo.shared.userPrivate?.user else { return }
        
        let keyFormatter = DateFormatter()
        keyFormatter.dateFormat = "yyyy-MM-dd"
        
        let startAndEndFormatter = DateFormatter()
        startAndEndFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        for (index, blocks) in [(user.availabilityType1 ?? []), (user.availabilityType2 ?? []), (user.availabilityType3 ?? []), (user.availabilityType4 ?? [])].enumerated() {
            let realType = index + 1
            
            for block in blocks {
                let startAndEndBlocks = block.split(separator: "->")
                
                guard let start = startAndEndFormatter.date(from: String(startAndEndBlocks[0])) else { continue }
                guard let end = startAndEndFormatter.date(from: String(startAndEndBlocks[1])) else { continue }
                let key = keyFormatter.string(from: start)
                
                switch realType {
                case 1:
                    availabilityType1Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
                case 2:
                    availabilityType2Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
                case 3:
                    availabilityType3Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
                case 4:
                    availabilityType4Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end))
                default:
                    continue
                }
            }
        }
        
        displayedBlocks = getBlocksToDisplay(selectedDay: selectedDay, selectedAvailabilityType: selectedAvailabilityType)
    }
    
    func addBlock() {
        
        let key = dateFormatter.string(from: selectedDay)
        var typeBlocks = [Block]()
        switch selectedAvailabilityType {
        case 1:
            typeBlocks = availabilityType1Blocks.filter { $0.dateKey == key }
        case 2:
            typeBlocks = availabilityType2Blocks.filter { $0.dateKey == key }
        case 3:
            typeBlocks = availabilityType3Blocks.filter { $0.dateKey == key }
        case 4:
            typeBlocks = availabilityType4Blocks.filter { $0.dateKey == key }
        default:
            break
        }
        
        var block = Block(id: "", dateKey: "", startTime: Date(), endTime: Date())
        
        let startAndEndFormatter = DateFormatter()
        startAndEndFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if typeBlocks.isEmpty {
            guard let start = startAndEndFormatter.date(from: "\(key) 12:00") else { return }
            guard let end = startAndEndFormatter.date(from: "\(key) 13:00") else { return }
            block = Block(id: UUID().uuidString, dateKey: key, startTime: start, endTime: end)
        } else if let lastBlock = typeBlocks.last {
            let startTime = lastBlock.endTime
            if let endTime = Calendar.current.date(byAdding: .minute, value: 60, to: startTime) {
                block = Block(id: UUID().uuidString, dateKey: key, startTime: startTime, endTime: endTime)
            }
        }
        
        switch selectedAvailabilityType {
        case 1:
            availabilityType1Blocks.append(block)
        case 2:
            availabilityType2Blocks.append(block)
        case 3:
            availabilityType3Blocks.append(block)
        case 4:
            availabilityType4Blocks.append(block)
        default:
            break
        }
        
        displayedBlocks = getBlocksToDisplay(selectedDay: selectedDay, selectedAvailabilityType: selectedAvailabilityType)
    }
    
    func deleteBlock(block: Block) {
        switch selectedAvailabilityType {
        case 1:
            if let index  = availabilityType1Blocks.firstIndex(where: { $0.id == block.id }) {
                availabilityType1Blocks.remove(at: index)
            }
        case 2:
            if let index  = availabilityType2Blocks.firstIndex(where: { $0.id == block.id }) {
                availabilityType2Blocks.remove(at: index)
            }
        case 3:
            if let index  = availabilityType3Blocks.firstIndex(where: { $0.id == block.id }) {
                availabilityType3Blocks.remove(at: index)
            }
        case 4:
            if let index  = availabilityType4Blocks.firstIndex(where: { $0.id == block.id }) {
                availabilityType4Blocks.remove(at: index)
            }
        default:
            break
        }
        displayedBlocks = getBlocksToDisplay(selectedDay: selectedDay, selectedAvailabilityType: selectedAvailabilityType)
    }
    
    func getBlocksToDisplay(selectedDay: Date, selectedAvailabilityType: Int) -> [Block] {
        
        let key = dateFormatter.string(from: selectedDay)
        
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
    
    private func updateAvailability() async -> Bool {
        isLoading.toggle()
        var body = UpdateUserBody()
        
        let simpleISODateFormatter = DateFormatter()
        simpleISODateFormatter.dateFormat = "yyyy-MM-dd HH:mm"

        let formatted1Blocks = availabilityType1Blocks.map { "\(simpleISODateFormatter.string(from: $0.startTime))->\(simpleISODateFormatter.string(from: $0.endTime))" }
        let formatted2Blocks = availabilityType2Blocks.map { "\(simpleISODateFormatter.string(from: $0.startTime))->\(simpleISODateFormatter.string(from: $0.endTime))" }
        let formatted3Blocks = availabilityType3Blocks.map { "\(simpleISODateFormatter.string(from: $0.startTime))->\(simpleISODateFormatter.string(from: $0.endTime))" }
        let formatted4Blocks = availabilityType4Blocks.map { "\(simpleISODateFormatter.string(from: $0.startTime))->\(simpleISODateFormatter.string(from: $0.endTime))" }
        
        body.updateAvailability = UpdateAvailability(availabilityType1: formatted1Blocks, availabilityType2: formatted2Blocks, availabilityType3: formatted3Blocks, availabilityType4: formatted4Blocks)
        let response = await executeUpdate(body: body)
        isLoading.toggle()
        return response
    }
    
    private func executeUpdate(body: UpdateUserBody) async -> Bool {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await APIGatewayService.shared.privateUpdateUser(userSub: userSub, body: body)
        switch response {
        case .success(_):
            return true
        case .failure(_):
            return false
        }
    }
}

//#Preview {
//    AvailabilityScreen()
//}

