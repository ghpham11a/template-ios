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
    
    @State var user = UserRepo.shared.userPrivate
    
    @State var payoutMethodId: String = ""
    @State var showBottomSheet: Bool = false
    
    var body: some View {
        ScrollView {
            HStack {
                HeadingText(title: "Payout methods")
                
                Button(action: {
                    Task {
                        await readUser()
                    }
                }) {
                    Text("Refresh")
                }
            }
            
            
            if payoutMethods.isEmpty {
                Text("No payout methods added")
            } else {
                VStack {
                    ForEach(payoutMethods, id: \.id) { payoutMethod in
                        HStack {
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                            
                            VStack {
                                Text("Bank Account")
                                Text("\(payoutMethod.accountHolderName ?? "") ...\(payoutMethod.last4 ?? "") (\((payoutMethod.currency ?? "").uppercased())")
                                if payoutMethod.status == "new" {
                                    Text("On hold")
                                }
                            }
                            .frame(alignment: .leading)
                            
                            Spacer()
                            
                            OutlinedButton(
                                text: "Edit",
                                iconName: "",
                                action: {
                                    payoutMethodId = payoutMethod.id ?? ""
                                    showBottomSheet.toggle()
                                }
                            )
                            .frame(width: 100.0)
                        }
                    
                    }
                }
                .sheet(isPresented: $showBottomSheet) {
                    VStack {
                        Button("Remove") {
                            Task {
                                await deletePayoutMethod(payoutMethodId: self.payoutMethodId)
                            }
                        }
                    }
                }
            }
            
            if let accountLinkUrl = user?.stripeAccount?.accountLinkUrl {
                Button(action: {
                    Task {
                        if let url = URL(string: accountLinkUrl) {
                            UIApplication.shared.open(url)
                        }
                    }
                }) {
                    Text("Verify account details through Stripe")
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
    
    private func readUser() async {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.privateReadUser(userSub: userSub, refresh: true)
        switch response {
        case .success(let data):
            user = UserRepo.shared.userPrivate
        case .failure(let error):
            break
        }
    }
    
    func deletePayoutMethod(payoutMethodId: String) async {
        let body = DeletePayoutMethodRequest(accountId: UserRepo.shared.userPrivate?.user?.stripeAccountId , payoutMethodId: payoutMethodId)
        let response = await APIGatewayService.shared.privateDeletePayoutMethod(body: body)
        switch response {
        case .success(let data):
            self.payoutMethodId = ""
            self.showBottomSheet = false
        case .failure(let error):
            break
        }
    }
}
