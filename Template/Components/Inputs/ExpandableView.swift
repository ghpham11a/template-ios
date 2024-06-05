//
//  ExpandableView.swift
//  Template
//
//  Created by Anthony Pham on 6/4/24.
//

import SwiftUI

struct ExpandableView<Content: View>: View {
    
    @State private var isExpanded = false
    let title: String
    let openedTitle: String
    let closedTitle: String
    let content: Content

    init(title: String, openedTitle: String, closedTitle: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.openedTitle = openedTitle
        self.closedTitle = closedTitle
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.headline)
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Text(isExpanded ? closedTitle : openedTitle)
                }
            }
            .padding()

            if isExpanded {
                content
                    .padding([.leading, .trailing, .bottom])
            }
            
            Divider()
        }
        .padding()
    }
}
