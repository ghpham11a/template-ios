//
//  CharlieScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/24/24.
//

import SwiftUI

struct CharlieScreen: View {
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        NavigationStack {
            Text("Charlie")
                .navigationTitle("Charlie")
        }
    }
}

//#Preview {
//    CharlieScreen()
//}
