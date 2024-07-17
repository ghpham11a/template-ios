//
//  Numpad.swift
//  Template
//
//  Created by Anthony Pham on 7/14/24.
//

import SwiftUI

struct Numpad: View {
    let onClick: (String) -> Void

    let buttons = [
        ["1", "2", "3"],
        ["4", "5", "6"],
        ["7", "8", "9"],
        [".", "0", "<-"]
    ]

    var body: some View {
        VStack {
            ForEach(buttons, id: \.self) { row in
                HStack {
                    ForEach(row, id: \.self) { label in
                        NumpadButton(label: label, onClick: onClick)
                    }
                }
            }
        }
    }
}

struct NumpadButton: View {
    let label: String
    let onClick: (String) -> Void

    var body: some View {
        Button(action: {
            onClick(label)
        }) {
            Text(label)
                .font(.title)
                .frame(width: 64, height: 64)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(4)
        }
    }
}
