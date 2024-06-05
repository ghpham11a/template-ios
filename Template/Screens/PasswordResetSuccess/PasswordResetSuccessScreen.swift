//
//  PasswordResetSuccessScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/4/24.
//

import SwiftUI

struct PasswordResetSucesssScreen: View {

    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack {
            Text("Password reset was a success. Please login using your new one.")
            Button("Ok") {
                path = NavigationPath()
            }
        }
    }
}
