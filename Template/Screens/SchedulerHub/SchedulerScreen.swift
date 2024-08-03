//
//  SchedulerScreen.swift
//  Template
//
//  Created by Anthony Pham on 7/31/24.
//

import SwiftUI

let DATE_FORMAT = "yyyy-MM-dd"
let DATE_TIME_FORMAT = "yyyy-MM-dd HH:mm"
let TIME_FORMAT = "HH:mm"

struct SchedulerOption {
    var date: String
    var times: [[Time]]
}

class Time: CustomStringConvertible {
    var start: Date
    var end: Date
    var isSelectable: Bool

    init(start: Date, end: Date) {
        self.start = start
        self.end = end
        self.isSelectable = true
    }

    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = TIME_FORMAT
        let s = dateFormatter.string(from: self.start)
        return "\(s)[\(self.isSelectable)]"
    }
}

struct SchedulerScreen: View {
    
    @Binding var path: NavigationPath
    @State var userId: String
    @State var availabilityType: String
    
    @State var durationOptions: [Int] = []
    @State var duration: Int = 0
    
    @State var schedulingOptions: [Int] = []
    @State var schedulingMethod: Int = 0
    
    @State var timeOptions: [SchedulerOption] = []
    @State var time2Options: [SchedulerOption] = []
    @State var selectedTime: Time? = nil
    
    @State var availabilityType1Blocks: [Block] = []
    @State var availabilityType2Blocks: [Block] = []
    @State var availabilityType3Blocks: [Block] = []
    @State var availabilityType4Blocks: [Block] = []
    
    @State var conflict = SchedulesRepository.shared.conflict
    
    let dateFormatter = DateFormatter()
    let timeFormatter = DateFormatter()
    let dateTimeFormatter = DateFormatter()
    
    @State var isLoading: Bool = true
    
    var body: some View {
        GeometryReader { geometry in
            
            if isLoading {
                LoadingScreen()
            } else {
                ScrollView {
                    
                    HeadingText(title: "How long?")
                    
                    self.generateDurations(durations: durationOptions, in: geometry)
                    
                    Divider()
                    
                    HeadingText(title: "What type?")
                    
                    Button(action: {
                        onSchedulingMethodChange(value: 1)
                    }) {
                        Text("Schedule Type 1")
                    }
                    .background(schedulingMethod == 1 ? Color.green : Color.cyan)
                    
                    Spacer()
                    
                    Button(action: {
                        onSchedulingMethodChange(value: 2)
                    }) {
                        Text("Schedule Type 2")
                    }
                    .background(schedulingMethod == 2 ? Color.green : Color.cyan)
 
                    Spacer()
                    
                    Button(action: {
                        onSchedulingMethodChange(value: 3)
                    }) {
                        Text("Schedule Type 3")
                    }
                    .background(schedulingMethod == 3 ? Color.green : Color.cyan)
                    
                    Divider()
                    
                    if schedulingMethod == 1 {
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
                    
//                    if schedulingMethod == 2 {
//                        VStack(alignment: .leading) {
//                            ForEach($time2Options, id: \.date) { day in
//                                VStack(alignment: .leading) {
//                                    Text(day.wrappedValue.date)
//                                        .frame(maxWidth: .infinity, alignment: .leading)
//                                    Spacer()
//                                    ForEach(day.times, id: \.description) { times in
//                                        self.generateTimes(times: times.wrappedValue, in: geometry)
//                                    }
//                                }
//                                .frame(maxWidth: .infinity, alignment: .leading)
//                            }
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                    }
                    
                    if schedulingMethod == 3 {
                        Text("Start immediately upon acceptance")
                    }
                    
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            path.append(Route.conflicts(userId: userId, availabilityType: availabilityType))
        }) {
            Text(isLoading ? "" : "Add conflicts")
        })
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
        schedulingOptions = [1, 2, 3]
    }
    
    private func generateDurations(durations: [Int], in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(durations, id: \.self) { tag in
                Button(action: {
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
                }) {
                    Text(TimeHelpers.shared.timeFormatter.string(from: tag.start))
                }                
                .background(getColor(tag))
                .disabled(tag.isSelectable == false)
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
    
    func getColor(_ tag: Time) -> Color {
        if (tag.isSelectable == false) {
            return Color.gray
        } else if (TimeHelpers.shared.timeFormatter.string(from: tag.start) == TimeHelpers.shared.timeFormatter.string(from: selectedTime?.start ?? Date())) {
            return Color.green
        } else {
            return Color.cyan
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

    func getOptions(duration: Int, blocks: [Block], masks: [Block]) -> [SchedulerOption] {
        let adjustedDuration = duration
        let (blockGroups, sortedDates) = getGroups(blocks: blocks)
        let (maskGroups, _) = getGroups(blocks: masks)
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

        for date in sortedDates {
            if let timesList = resultMap[date], let maskList = maskGroups[date] {
                for times in timesList {
                    for time in times {
                        var isSelectable = true
                        for mask in maskList {
                            if !isSelectable {
                                break
                            }
                            if mask.id == "IGNORE" {
                                continue
                            }
                            let adjustedMaskStart = Calendar.current.date(byAdding: .minute, value: -5, to: mask.startTime)!
                            let adjustedMaskEnd = Calendar.current.date(byAdding: .minute, value: 5, to: mask.endTime)!
                            if time.start < adjustedMaskEnd && time.end > adjustedMaskStart {
                                isSelectable = false
                            }
                        }
                        time.isSelectable = isSelectable
                    }
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
        
        if SchedulesRepository.shared.userId == userId {
            updateTimeOptions()
            return
        }
        
        SchedulesRepository.shared.userId = userId
        
        let response = await APIGatewayService.shared.publicReadUser(userSub: userId)
        switch response {
        case .success(let data):
            
            SchedulesRepository.shared.user = data
            
            if let blocks = data.availabilityType1 {
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
            isLoading.toggle()
        case .failure(let error):
            isLoading.toggle()
        }
    }
    
    func onDurationChange(value: Int) {
        duration = value
        updateTimeOptions()
    }
    
    func onSchedulingMethodChange(value: Int) {
        schedulingMethod = value
        updateTimeOptions()
    }
    
    func updateTimeOptions() {
        
        if duration == 0 || schedulingMethod == 0 {
            return
        }

        if schedulingMethod == 1 || schedulingMethod == 2 {
            switch availabilityType {
            case "1":
                timeOptions = getOptions(duration: duration, blocks: Array(availabilityType1Blocks), masks: [SchedulesRepository.shared.conflict])
            case "2":
                timeOptions = getOptions(duration: duration, blocks: Array(availabilityType2Blocks), masks: [SchedulesRepository.shared.conflict])
            case "3":
                timeOptions = getOptions(duration: duration, blocks: Array(availabilityType3Blocks), masks: [SchedulesRepository.shared.conflict])
            case "4":
                timeOptions = getOptions(duration: duration, blocks: Array(availabilityType4Blocks), masks: [SchedulesRepository.shared.conflict])
            default:
                break
            }
            
//            let dates = TimeHelpers.shared.getDatesInRange()
//            var blocks = [Block]()
//            for date in dates {
//                guard let start = TimeHelpers.shared.dateTimeFormatter.date(from: "\(date) 00:00") else { return }
//                guard let end = TimeHelpers.shared.dateTimeFormatter.date(from: "\(date) 23:45") else { return }
//                blocks.append(Block(id: UUID().uuidString, dateKey: date, startTime: start, endTime: end))
//            }
//            time2Options = getOptions(duration: duration, blocks: blocks, masks: [])
        }
        
//        if schedulingMethod == 2 {
//            let dates = TimeHelpers.shared.getDatesInRange()
//            var blocks = [Block]()
//            for date in dates {
//                guard let start = TimeHelpers.shared.dateTimeFormatter.date(from: "\(date) 00:00") else { return }
//                guard let end = TimeHelpers.shared.dateTimeFormatter.date(from: "\(date) 23:45") else { return }
//                blocks.append(Block(id: UUID().uuidString, dateKey: date, startTime: start, endTime: end))
//            }
//            DispatchQueue.main.async {
//                self.timeOptions = self.getOptions(duration: duration, blocks: blocks, masks: [])
//                self.isLoading.toggle()
//            }
//        }
        
        if schedulingMethod == 3 {
            timeOptions = []
        }
    }
}
