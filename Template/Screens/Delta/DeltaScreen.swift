//
//  DeltaScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/24/24.
//

import SwiftUI

struct DeltaScreen: View {
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        NavigationStack {
            Text("Delta")
                .navigationTitle("Delta")
        }
    }
}

//#Preview {
//    DeltaScreen()
//}

