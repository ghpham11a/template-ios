//
//  CheckboxRow.swift
//  Template
//
//  Created by Anthony Pham on 6/9/24.
//

import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 8) {
            Image(systemName: configuration.isOn ? "checkmark.square" : "square")
                .resizable()
                .frame(width: 20, height: 20)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
            
            configuration.label
            
            Spacer()
        }
    }
}

struct CheckboxRow: View {
    var title: String
    @State var isChecked: Bool

    var onCheckedChange: (Bool) -> Void

    var body: some View {
        Button(action: {
            self.isChecked.toggle()
            self.onCheckedChange(self.isChecked)
        }) {
            HStack {
                Text(title)
                    .foregroundColor(.black)
                Spacer()
                CheckBoxView(isChecked: $isChecked)
            }
            .padding()
        }
    }
}

struct CheckBoxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        Image(systemName: isChecked ? "checkmark.square" : "square")
            .foregroundColor(.blue)
            .onTapGesture {
                self.isChecked.toggle()
            }
    }
}
