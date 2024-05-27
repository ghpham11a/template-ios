//
//  BackButton.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI



struct BackButton: View {
    
    enum Icon {
        case back
        case remove
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var label: String
    @State private var description: String
    @State private var icon: Icon = .back
    
    // Custom initializer
    init(icon: BackButton.Icon = .back, label: String = "", description: String = "") {
        self.icon = icon
        self.label = label
        self.description = description
    }
    
    var body: some View {
        Button(action: {
            TabBarManager.shared.pop()
            self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
                Image(systemName: icon == .back ? "chevron.left" : "xmark")
                    .foregroundColor(.blue)
                
                if label != "" {
                    Text("Back")
                        .foregroundColor(.blue)
                }
            }
        }
    }
}
