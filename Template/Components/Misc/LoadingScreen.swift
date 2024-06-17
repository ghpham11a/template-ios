//
//  LoadingScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/16/24.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle())
                .scaleEffect(1.5) // Adjust the size of the spinner
                .padding()
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground)) // Background color
        .edgesIgnoringSafeArea(.all) // Optional: Ignore safe area if needed
    }
}
