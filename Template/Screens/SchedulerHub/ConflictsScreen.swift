//
//  ConflictsScreen.swift
//  Template
//
//  Created by Anthony Pham on 8/2/24.
//

import SwiftUI

struct ConflictsScreen: View {
    
    @Binding var path: NavigationPath
    @State var userId: String
    @State var availabilityType: String
    
    @State var durationOptions: [Int] = []
    @State var duration: Int = 0
    
    @State var timeOptions: [SchedulerOption] = []
    @State var time2Options: [SchedulerOption] = []
    @State var selectedTime: Time? = nil
    
    @State var availabilityType1Blocks: [Block] = []
    @State var availabilityType2Blocks: [Block] = []
    @State var availabilityType3Blocks: [Block] = []
    @State var availabilityType4Blocks: [Block] = []
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    
    var body: some View {
        GeometryReader { geometry in
            
            ScrollView {
                
                HeadingText(title: "How long?")
                
                self.generateDurations(durations: durationOptions, in: geometry)
                
                Divider()
                
                Text("Select a time")
                
                VStack(alignment: .leading) {
                    ForEach($timeOptions, id: \.date) { day in
                        VStack(alignment: .leading) {
                            Text(day.wrappedValue.date)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Spacer()
                            ForEach(day.times, id: \.description) { times in
                                self.generateTimes(times: times.wrappedValue, in: geometry)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .onAppear {
            
            dateTimeFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            timeFormatter.dateFormat = "HH:mm"
            
            setupDurationAndSchedulingMethods()
            
            Task {
                await fetchUser()
            }
        }
    }
    
    func setupDurationAndSchedulingMethods() {
        durationOptions = [30, 45, 60, 90]
    }
    
    private func generateDurations(durations: [Int], in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(durations, id: \.self) { tag in
                Button(action: {
                    SchedulesRepository.shared.duration = tag
                    onDurationChange(value: tag)
                }) {
                    Text("\(tag) minutes")
                        .padding()
                }
                .background(tag == duration ? Color.green : Color.cyan)
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { dimension in
                    if (abs(width - dimension.width) > geometry.size.width) {
                        width = 0
                        height -= dimension.height
                    }
                    let result = width
                    if tag == durations.last {
                        width = 0 // Last item
                    } else {
                        width -= dimension.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    let result = height
                    if tag == durations.last {
                        height = 0 // Last item
                    }
                    return result
                })
            }
        }
    }
    
    private func generateTimes(times: [Time], in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(times, id: \.start.description) { tag in
                Button(action: {
                    selectedTime = tag
                    SchedulesRepository.shared.updateConflict(time: tag)
                }) {
                    Text(timeFormatter.string(from: tag.start))
                        .padding()
                }
                .background(TimeHelpers.shared.timeFormatter.string(from: tag.start) == TimeHelpers.shared.timeFormatter.string(from: selectedTime?.start ?? Date())  ? Color.green : Color.cyan)
                .padding([.horizontal, .vertical], 4)
                .alignmentGuide(.leading, computeValue: { dimension in
                    if (abs(width - dimension.width) > geometry.size.width) {
                        width = 0
                        height -= dimension.height
                    }
                    let result = width
                    if tag.description == times.last?.description {
                        width = 0 // Last item
                    } else {
                        width -= dimension.width
                    }
                    return result
                })
                .alignmentGuide(.top, computeValue: { _ in
                    let result = height
                    if tag.description == times.last?.description {
                        height = 0 // Last item
                    }
                    return result
                })
            }
        }
    }
    
    func getGroups(blocks: [Block]) -> ([String: [Block]], [String]) {
        var dates = Set<String>()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DATE_FORMAT

        for block in blocks {
            let start = dateFormatter.string(from: block.startTime)
            dates.insert(start)
        }

        let sortedDates = dates.sorted()
        var result = [String: [Block]]()

        for date in sortedDates {
            result[date] = []
        }

        for block in blocks {
            let start = dateFormatter.string(from: block.startTime)
            result[start]?.append(block)
        }

        return (result, sortedDates)
    }

    func getOptions(duration: Int, blocks: [Block]) -> [SchedulerOption] {
        let adjustedDuration = duration
        let (blockGroups, sortedDates) = getGroups(blocks: blocks)
        var resultMap = [String: [[Time]]]()

        for date in sortedDates {
            resultMap[date] = []
            if let blocks = blockGroups[date] {
                for block in blocks {
                    var blockResult = [Time]()
                    var start = block.startTime
                    let end = block.endTime

                    while start <= end {
                        let projection = Calendar.current.date(byAdding: .minute, value: adjustedDuration, to: start)!
                        if projection <= end {
                            blockResult.append(Time(start: start, end: projection))
                        }
                        start = projection
                    }

                    resultMap[date]?.append(blockResult)
                }
            }
        }
        
        var results = [SchedulerOption]()
        
        for date in sortedDates {
            results.append(SchedulerOption(date: date, times: resultMap[date] ?? []))
            
        }

        return results
    }
    
    private func fetchUser() async {
        let data = SchedulesRepository.shared.user
        
        if SchedulesRepository.shared.duration != 0 {
            duration = SchedulesRepository.shared.duration
        }
        if SchedulesRepository.shared.conflict.id != "IGNORE" {
            let startTime = SchedulesRepository.shared.conflict.startTime
            let endTime = SchedulesRepository.shared.conflict.endTime
            let newSelectedTime = Time(start: startTime, end: endTime)
            // Block(id: UUID().uuidString, dateKey: dateKey, startTime: startTime, endTime: endTime)
            selectedTime = newSelectedTime
        }
        
        if let blocks = data?.availabilityType1 {
            for block in blocks {
                let startAndEnd = block.split(separator: "->")
                guard startAndEnd.count == 2 else { continue }
                let start = startAndEnd[0]
                let end = startAndEnd[1]
                guard let startDate = dateTimeFormatter.date(from: String(start)) else { continue }
                guard let endDate = dateTimeFormatter.date(from: String(end)) else { continue }
                let key = dateFormatter.string(from: startDate)
                availabilityType1Blocks.append(Block(id: UUID().uuidString, dateKey: key, startTime: startDate, endTime: endDate))
            }
        }
        
        updateTimeOptions()
    }
    
    func onDurationChange(value: Int) {
        duration = value
        updateTimeOptions()
    }
    
    func updateTimeOptions() {
        
        if duration == 0 {
            return
        }

        switch availabilityType {
        case "1":
            timeOptions = getOptions(duration: duration, blocks: availabilityType1Blocks)
        case "2":
            timeOptions = getOptions(duration: duration, blocks: availabilityType2Blocks)
        case "3":
            timeOptions = getOptions(duration: duration, blocks: availabilityType3Blocks)
        case "4":
            timeOptions = getOptions(duration: duration, blocks: availabilityType4Blocks)
        default:
            break
        }
    }
}
