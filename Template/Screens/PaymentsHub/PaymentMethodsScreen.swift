//
//  PaymentMethodsScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/17/24.
//

import SwiftUI

struct PaymentMethodsScreen: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            HeadingText(title: "Payment methods")
        }
    }
}
