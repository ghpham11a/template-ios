//
//  PaymentsHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/17/24.
//

import SwiftUI

struct PaymentsHubScreen: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        ScrollView {
            HeadingText(title: "Payments & payouts")
            
            Spacer()
            
            HeadingText(title: "Payments")
            
            HorizontalIconButton(iconName: "star.fill", buttonText: "Payment methods", action: {
                path.append(Route.paymentMethods)
            })
            
            HorizontalIconButton(iconName: "star.fill", buttonText: "Your payments", action: {
                path.append(Route.yourPayments)
            })
            
            Divider()
            
            HeadingText(title: "Payouts")
            
            HorizontalIconButton(iconName: "star.fill", buttonText: "Payout methods", action: {
                path.append(Route.payoutMethods)
            })
        }
    }
}

//#Preview {
//    DeltaScreen()
//}
