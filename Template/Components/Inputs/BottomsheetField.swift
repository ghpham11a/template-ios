//
//  BottomsheetField.swift
//  Template
//
//  Created by Anthony Pham on 6/15/24.
//

import SwiftUI

struct BottomsheetField<Content: View>: View {
    
    @Binding var isExpanded: Bool
    @Binding var isEnabled: Bool
    let title: String
    let content: Content
    let onExpansionChanged: ((Bool) -> Void)?

    init(isExpanded: Binding<Bool>, isEnabled: Binding<Bool>, title: String, @ViewBuilder content: () -> Content, onExpansionChanged: ((Bool) -> Void)? = nil) {
        self._isExpanded = isExpanded
        self._isEnabled = isEnabled
        self.title = title
        self.content = content()
        self.onExpansionChanged = onExpansionChanged
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {
                isExpanded.toggle()
            }) {
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(.blue)
                    Text(title)
                        .foregroundColor(isEnabled ? .primary : .secondary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
            Divider()
                .padding(.leading)
        }
        .background(Color.white)
        .sheet(isPresented: $isExpanded) {
            content
                .padding()
        }
    }
}
