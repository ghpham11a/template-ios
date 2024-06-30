//
//  PayoutMethodsScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/17/24.
//

import SwiftUI

struct PayoutMethodsScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var isLoading: Bool = false
    @State var isAddPayoutMethodEnabled: Bool = true
    
    @State var payoutMethods: [PayoutMethod] = []
    
    var body: some View {
        ScrollView {
            HeadingText(title: "Payout methods")
            
            if payoutMethods.isEmpty {
                Text("No payout methods added")
            } else {
                VStack {
                    ForEach(payoutMethods, id: \.id) { payoutMethod in
                        HStack {
                            Text(payoutMethod.accountHolderName ?? "")
                            Spacer()
                            OutlinedButton(
                                text: "Edit",
                                iconName: "",
                                action: {
                                    
                                }
                            )
                        }
                    
                    }
                }
            }
            
            LoadingButton(title: "Add payout method", isLoading: $isLoading, isEnabled: $isAddPayoutMethodEnabled, action: {
                Task {
                    path.append(Route.addPayout)
                }
            })
        }
        .padding()
        .onAppear {
            Task {
                await readPayoutMethods()
            }
        }
    }
    
    func readPayoutMethods() async {
        let response = await APIGatewayService.shared.privateReadPayoutMethods()
        switch response {
        case .success(let data):
            payoutMethods = data.payoutMethods ?? []
        case .failure(let error):
            break
        }
    }
}
