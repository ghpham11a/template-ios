//
//  AddPayoutScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/29/24.
//

import SwiftUI

struct AddBankInfoScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var country: String
    
    @State var isLoading = false
    @State var isContinueEnabled = true
    
    @State var accountHolderName: String = "John Doe"
    @State var routingNumber: String = "110000000"
    @State var accountNumber: String = "000123456789"
    @State var accountNumberConfirmation: String = "000123456789"

    
    var body: some View {
        ScrollView {

            Text("Account holder name")
            OutlinedTextField(title: "Account holder name", placeholder: "", text: $accountHolderName)
            
            Text("Routing number")
            OutlinedTextField(title: "Routing number", placeholder: "", text: $routingNumber)
            
            Text("Account number")
            OutlinedTextField(title: "Account number", placeholder: "", text: $accountNumber)
            
            Text("Confirm account number")
            OutlinedTextField(title: "Confirm account number", placeholder: "", text: $accountNumberConfirmation)
            
            LoadingButton(title: "Continue", isLoading: $isLoading, isEnabled: $isContinueEnabled, action: {
                Task {
                    let response = await onContinue()
                    if let responseSuccess = response, let payoutMethodId = responseSuccess.id {
                        path.removeLast(path.count)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            
                        }
                    }
                }
            })
            
        }
        .padding()
    }
    
    private func onContinue() async -> CreatePayoutMethodResponse? {
        DispatchQueue.main.async { self.isLoading = true }
        let body = CreatePayoutMethodRequest(route: "hosted_manual_entry", customerId: UserRepo.shared.userPrivate?.user?.stripeCustomerId ?? "", accountId: UserRepo.shared.userPrivate?.user?.stripeAccountId ?? "", accountHolderName: accountHolderName, accountNumber: accountNumber, country: country, currency: getCountryCurrency(country: country), routingNumber: routingNumber)
        let response = await APIGatewayService.shared.privateCreatePayoutMethod(body: body)
        switch response {
        case .success(let data):
            DispatchQueue.main.async { self.isLoading = false }
            return data
        case .failure(let error):
            DispatchQueue.main.async { self.isLoading = false }
            return nil
        }
    }
    
    func getCountryCurrency(country: String) -> String {
        switch country {
        case "US":
            return "USD"
        default:
            return ""
        }
    }
}
