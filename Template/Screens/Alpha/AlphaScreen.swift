//
//  AlphaScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/20/24.
//

import SwiftUI

struct AlphaScreen: View {
    var body: some View {
        NavigationStack {
            Text("Alpha")
                .navigationTitle("Alpha")
        }
        .onAppear {
            Router.shared.replace(url: Constants.Route.ALPHA_TAB)
        }
    }
}

//#Preview {
//    AlphaScreen()
//}
