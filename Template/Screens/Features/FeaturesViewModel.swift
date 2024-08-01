//
//  BravoViewModel.swift
//  Template
//
//  Created by Anthony Pham on 5/23/24.
//

import Foundation

class FeaturesViewModel: ObservableObject {
    
    @Published var todos: [Todo] = []
    @Published var errorMessage: String?
    
    @Published var newItems: [Feature] = []
    @Published var oldItems: [Feature] = []
    
    
    func fetchItems() {
        DispatchQueue.main.async {
            self.newItems = [
                Feature(title: "Thing Introduction", description: "This is a flow that guides you through several steps one at a time", route: .thingIntro),
                Feature(title: "Filter List", description: "List of a lot of items that can be filtered", route: .filterList),
                Feature(title: "UIKit View", description: "A screen using UIKit", route: .uikitView),
                Feature(title: "Map", description: "Map view with device location and the ability to search more locations", route: .mapView),
                Feature(title: "Tabbed List", description: "Switch between multiple lists using a tab bar at the top", route: .tabbedList),
                Feature(title: "Send Payments", description: "Send a payment to another account via Stripe", route: .sendPaymentHub),
                Feature(title: "Masked Phone Call", description: "Make a masked phone call using Twilio", route: .proxyCallHub),
                Feature(title: "Video Calls", description: "Make a video call using Azure Communication Service", route: .videoCallHub),
                Feature(title: "Chat", description: "Chat using Azure Communication Service", route: .chatHub),
                Feature(title: "Voice Calls", description: "Make a VOIP call using Azure Communication Service", route: .voiceCallHub),
                Feature(title: "Scheduler", description: "Choose an available time on another user's schedule", route: .schedulerHub),
            ]
            
            self.oldItems = []
        }
    }
    
    func fetchTodos() {
        Task {
            do {
                let data = try await JSONPlaceholderRepo.shared.fetchTodos()
                DispatchQueue.main.async {
                    self.todos = data ?? []
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
