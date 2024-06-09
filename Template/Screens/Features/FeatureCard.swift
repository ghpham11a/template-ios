//
//  FeatureCard.swift
//  Template
//
//  Created by Anthony Pham on 6/8/24.
//

import SwiftUI

struct FeaturesCard: View {
    var title: String
    var description: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.black)
                Spacer()
                    .frame(height: 8)
                Text(description)
                    .foregroundStyle(.black)
            }
            .frame(maxWidth: .infinity)
            .background(Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
