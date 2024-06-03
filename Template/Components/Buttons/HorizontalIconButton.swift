//
//  HorizontalIconButton.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import SwiftUI

struct HorizontalIconButton: View {
    var iconName: String
    var buttonText: String
    var action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    Image(systemName: iconName)
                        .foregroundColor(.blue) // Customize the color as needed
                    Text(buttonText)
                        .foregroundColor(.primary) // Customize the text color as needed
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray) // Customize the chevron color as needed
                }
                .padding()
            }
            Divider()
                .padding(.leading) // Optional: Adjust padding to match your layout
        }
        .background(Color.white) // Optional: Customize the background color
    }
}
