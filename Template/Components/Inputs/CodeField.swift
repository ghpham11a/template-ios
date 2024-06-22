//
//  CodeField.swift
//  Template
//
//  Created by Anthony Pham on 6/22/24.
//

import SwiftUI

struct CodeField: View {
    @Binding var code: [String]
    // @Binding var focusedField: Int?
    
    @FocusState private var focusedField: Int?

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<6, id: \.self) { index in
                TextField("", text: $code[index])
                    .frame(width: 40, height: 40)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .focused($focusedField, equals: index)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: code[index]) { _, newValue in
                        if newValue.count == 1 {
                            moveToNextField(from: index)
                        } else if newValue.isEmpty {
                            moveToPreviousField(from: index)
                        }
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { notification in
                        if let textField = notification.object as? UITextField, let text = textField.text {
                            if text.isEmpty {
                                moveToPreviousField(from: index)
                            }
                        }
                    }
            }
        }
        .padding()
    }
    
    private func moveToNextField(from index: Int) {
        if index < 5 {
            focusedField = index + 1
        } else {
            // or any other action when the last field is filled
            focusedField = nil
        }
    }
    
    private func moveToPreviousField(from index: Int) {
        if index > 0 {
            focusedField = index - 1
        } else {
            // or any other action when the first field is empty
            focusedField = nil
        }
    }
}
