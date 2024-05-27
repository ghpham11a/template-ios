//
//  AlphaScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/20/24.
//

import SwiftUI

struct AlphaScreen: View {
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        NavigationStack {
            Text("Alpha")
                .navigationTitle("Alpha")
        }
    }
}

//#Preview {
//    AlphaScreen()
//}
