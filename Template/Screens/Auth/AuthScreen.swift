//
//  AuthScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import SwiftUI

struct AuthScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            Text("Auth Screen")
        }
        .navigationBarTitle("Auth Screen", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton())
        .onAppear {
            Router.shared.push(url: "auth")
        }
    }
}
