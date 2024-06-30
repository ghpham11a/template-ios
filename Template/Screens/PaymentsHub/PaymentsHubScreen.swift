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
        .onAppear {
            Task {
                await readUser()
            }
        }
    }
    
    private func readUser() async {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.privateReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            break
        case .failure(let error):
            break
        }
    }
}

//#Preview {
//    DeltaScreen()
//}
