//
//  ThingDescriptionScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/9/24.
//

import SwiftUI

struct ThingDescriptionScreen: View {
    
    @StateObject var viewModel: ThingViewModel
    
    @State var text: String =  ""
    @State private var wordCount: Int = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Enter your text:")
                .font(.headline)

            TextEditor(text: $text)
                .onChange(of: text) { oldValue, newValue in
                    let words = newValue.split { $0 == " " || $0.isNewline }
                    if words.count > 200 {
                        // Only keep the first 200 words
                        text = words.prefix(200).joined(separator: " ")
                    }
                    viewModel.onThingDescriptionChange(description: newValue)
                    wordCount = words.count
                }
                .padding()
                .border(Color.gray, width: 1)
                .frame(height: 200)

            Text("Word count: \(wordCount)/200")
                .font(.subheadline)
                .foregroundColor(wordCount > 200 ? .red : .primary)
                .padding([.top, .bottom], 10)
            
            Spacer()
        }
        .padding()
    }
}

