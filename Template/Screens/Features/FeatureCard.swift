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
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
                    .frame(height: 8)
                Text(description)
                    .foregroundStyle(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
//        .buttonStyle(PlainButtonStyle())
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 1)
    }
}
