//
//  OutlinedButton.swift
//  Template
//
//  Created by Anthony Pham on 6/7/24.
//

import SwiftUI

struct OutlinedButton: View {
    var text: String
    var iconName: String
    var action: () -> Void
    var size: CGFloat = 56 // Default size
    var cornerRadius: CGFloat = 8 // Default corner radius

    var body: some View {
        Button(action: action) {
            ZStack {
                HStack {
                    Image(systemName: iconName)
                        .padding(.leading, 16)
                    Spacer()
                }
                Text(text)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
            }
        }
        .frame(height: size)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(Color.black, lineWidth: 1)
        )
        .cornerRadius(cornerRadius)
    }
}

