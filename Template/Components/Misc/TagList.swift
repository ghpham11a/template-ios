//
//  TagList.swift
//  Template
//
//  Created by Anthony Pham on 7/15/24.
//

import SwiftUI

struct TagList: View {
    let tags: [Tag]

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }
    }

    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(tags, id: \.id) { tag in
                TagView(tag: tag.title ?? "")
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { dimension in
                        if (abs(width - dimension.width) > geometry.size.width) {
                            width = 0
                            height -= dimension.height
                        }
                        let result = width
                        if tag == tags.last {
                            width = 0 // Last item
                        } else {
                            width -= dimension.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { _ in
                        let result = height
                        if tag == tags.last {
                            height = 0 // Last item
                        }
                        return result
                    })
            }
        }
    }
}

struct TagView: View {
    let tag: String

    var body: some View {
        Text(tag)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
    }
}
