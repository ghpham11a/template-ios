//
//  CharlieScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/24/24.
//

import SwiftUI

struct CharlieScreen: View {
    var body: some View {
        NavigationStack {
            Text("Charlie")
                .navigationTitle("Charlie")
        }
        .onAppear {
            Router.shared.replace(url: Constants.Route.CHARLIE_TAB)
        }
    }
}

//#Preview {
//    DeltaScreen()
//}
