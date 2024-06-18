//
//  YourPaymentsScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/17/24.
//

import SwiftUI

struct YourPaymentsScreen: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            HeadingText(title: "Your payments")
        }
    }
}
