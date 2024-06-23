//
//  ExpandableView.swift
//  Template
//
//  Created by Anthony Pham on 6/4/24.
//

import SwiftUI

struct ExpandableView<OpenedContent: View, ClosedContent: View>: View {
    
    @Binding var isExpanded: Bool
    @Binding var isEnabled: Bool
    let title: String
    let openedTitle: String
    let closedTitle: String
    let openedContent: OpenedContent
    let closedContent: ClosedContent
    let onExpansionChanged: ((Bool) -> Void)?

    init(isExpanded: Binding<Bool>, isEnabled: Binding<Bool>, title: String, openedTitle: String, closedTitle: String, @ViewBuilder openedContent: () -> OpenedContent, closedContent: () -> ClosedContent, onExpansionChanged: ((Bool) -> Void)? = nil) {
        self._isExpanded = isExpanded
        self._isEnabled = isEnabled
        self.title = title
        self.openedTitle = openedTitle
        self.closedTitle = closedTitle
        self.openedContent = openedContent()
        self.closedContent = closedContent()
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
                openedContent
                    .padding([.leading, .trailing, .bottom])
            } else {
                closedContent
                    .padding([.leading, .trailing, .bottom])
            }
            
            Divider()
        }
    }
}
