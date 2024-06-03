//
//  NewScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import SwiftUI

struct NewScreen: View {
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        List{
            Text("New Screen")
        }
    }
}
