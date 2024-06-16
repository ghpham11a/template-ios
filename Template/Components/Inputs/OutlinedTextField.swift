//
//  OutlinedTextField.swift
//  Template
//
//  Created by Anthony Pham on 6/15/24.
//

import SwiftUI

struct OutlinedTextField: View {
    
    var title: String
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
            Text(title)
                .foregroundColor(.gray)
                .padding(.leading)
                .background(Color.white)
                .offset(x: 10, y: -10)
        }
        .padding(.top, 10)
    }
}
