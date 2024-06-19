//
//  ThingViewModel.swift
//  Template
//
//  Created by Anthony Pham on 6/16/24.
//

import Foundation

class ThingViewModel: ObservableObject {
    
    @Published var pageCount: Int = 1
    @Published var currentPage: Int = 0
    @Published var isNextEnabled: Bool = false
    @Published var isSaveEnabled: Bool = false
    @Published var availableThingTypes: [ThingType] = []
    @Published var isLoading: Bool = false
    
    @Published var thing = Thing()
    
    init() {
        DispatchQueue.main.async {
            self.availableThingTypes = [
                ThingType(group: "GROUP 1", title: "Type 1", description: "Type 1 description"),
                ThingType(group: "GROUP 1", title: "Type 2", description: "Type 2 description"),
                ThingType(group: "GROUP 2", title: "Type 3", description: "Type 3 description"),
                ThingType(group: "GROUP 2", title: "Type 4", description: "Type 4 description"),
            ]
        }
    }
    
    func udpatePageCount(pageCount: Int) {
        DispatchQueue.main.async {
            self.pageCount = pageCount
        }
    }
    
    func updateCurrentPage(currentPage: Int) {
        DispatchQueue.main.async {
            self.currentPage = currentPage
        }
    }
    
    func selectThingType(thingType: ThingType) {
        DispatchQueue.main.async {
            if self.thing.thingType?.title == thingType.title {
                self.thing.thingType = nil
            } else {
                self.thing.thingType = thingType
            }
            self.validateThing(screen: Constants.ThingScreen.THING_TYPE)
        }
    }
    
    func onThingDescriptionChange(description: String) {
        DispatchQueue.main.async {
            self.thing.thingDescription = description
            self.validateThing(screen: Constants.ThingScreen.THING_DESCRIPTION)
        }
    }
    
    func validateThing(screen: String) {
        DispatchQueue.main.async {
            switch screen {
            case Constants.ThingScreen.THING_TYPE:
                let thingTypeNotEmpty = self.thing.thingType != nil
                self.isNextEnabled = thingTypeNotEmpty
                self.isSaveEnabled = thingTypeNotEmpty && (self.currentPage == self.pageCount - 1)
            case Constants.ThingScreen.THING_DESCRIPTION:
                let thingDescriptionNotEmpty = self.thing.thingDescription != nil
                let thingDescriptionNotZero = self.thing.thingDescription?.count != 0
                self.isNextEnabled = thingDescriptionNotEmpty && thingDescriptionNotZero
                self.isSaveEnabled = (thingDescriptionNotEmpty && thingDescriptionNotZero) && (self.currentPage == self.pageCount - 1)
            default:
                break
            }
        }
    }
    
    func saveThing() async -> Bool {
        DispatchQueue.main.async { self.isLoading = true }
        let response = await ThingRepository.shared.createThing(thing: thing)
        switch response {
        case .success(let data):
            DispatchQueue.main.async { self.isLoading = false }
            return true
        case .failure(let error):
            DispatchQueue.main.async { self.isLoading = false }
            return false
        }
    }
}
