//
//  ExpandableView.swift
//  Template
//
//  Created by Anthony Pham on 6/4/24.
//

import SwiftUI

struct ExpandableView<Content: View>: View {
    
    @Binding var isExpanded: Bool
    @Binding var isEnabled: Bool
    let title: String
    let openedTitle: String
    let closedTitle: String
    let content: Content
    let onExpansionChanged: ((Bool) -> Void)?

    init(isExpanded: Binding<Bool>, isEnabled: Binding<Bool>, title: String, openedTitle: String, closedTitle: String, @ViewBuilder content: () -> Content, onExpansionChanged: ((Bool) -> Void)? = nil) {
        self._isExpanded = isExpanded
        self._isEnabled = isEnabled
        self.title = title
        self.openedTitle = openedTitle
        self.closedTitle = closedTitle
        self.content = content()
        self.onExpansionChanged = onExpansionChanged
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isEnabled ? .primary : .secondary)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                        onExpansionChanged?(isExpanded)
                    }
                }) {
                    Text(isExpanded ? closedTitle : openedTitle)
                }
                .disabled(!isEnabled)
                .foregroundColor(isEnabled ? .primary : .secondary)
            }
            .padding()

            if isExpanded {
                content
                    .padding([.leading, .trailing, .bottom])
            }
            
            Divider()
        }
    }
}
