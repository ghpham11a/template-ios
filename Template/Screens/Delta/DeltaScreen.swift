//
//  DeltaScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/24/24.
//

import SwiftUI

struct DeltaScreen: View {
    var body: some View {
        NavigationStack {
            Text("Delta")
                .navigationTitle("Delta")
        }
        .onAppear {
            Router.shared.replace(url: "delta")
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

