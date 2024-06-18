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
    var isLabelOnly: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    Image(systemName: iconName)
                        .foregroundColor(.blue)
                    Text(buttonText)
                        .foregroundColor(.primary)
                    Spacer()
                    if !isLabelOnly {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
            }
//            Divider()
//                .padding(.leading)
        }
        .background(Color.white)
    }
}
