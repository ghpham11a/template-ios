//
//  PaymentMethodsScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/17/24.
//

import StripePaymentSheet
import SwiftUI

struct PaymentMethodsScreen: View {
    
    @Binding var path: NavigationPath
    @State var isLoading: Bool = false
    @State var isAddPaymentMethodEnabled: Bool = true
    
    @State var paymentSheet: PaymentSheet? = nil
    
    @State var paymentMethods: [PaymentMethod] = []
    
    @State var paymentMethodId: String = ""
    @State var showBottomSheet: Bool = false
    
    var body: some View {
        ScrollView {
            HeadingText(title: "Payment methods")
            
            if paymentMethods.isEmpty {
                Text("No payment methods added")
            } else {
                VStack {
                    ForEach(paymentMethods, id: \.id) { paymentMethod in
                        HStack {
                            Text(paymentMethod.brand ?? "")
                            VStack {
                                Text(paymentMethod.last4 ?? "NULL")
                                Text("\(paymentMethod.expMonth ?? "") \(paymentMethod.expYear ?? 0)")
                            }
                            Spacer()
                            OutlinedButton(
                                text: "Edit",
                                iconName: "",
                                action: {
                                    paymentMethodId = paymentMethod.id ?? ""
                                    showBottomSheet.toggle()
                                }
                            )
                            .frame(width: 100)
                        }
                        .padding()
                    }
                }
                .sheet(isPresented: $showBottomSheet) {
                    VStack {
                        Button("Set Default") {
                            
                        }
                        Divider()
                        Button("Remove") {
                            Task {
                                await deletePaymentMethod(paymentMethodId: self.paymentMethodId)
                            }
                        }
                    }
                }
            }
            
            LoadingButton(title: "Add payment method", isLoading: $isLoading, isEnabled: $isAddPaymentMethodEnabled, action: {
                Task {
                    await onAddPaymentMethodTapped()
                }
            })
        }
        .padding()
        .onAppear {
            Task {
                await readPaymentMethods()
            }
        }
    }
    
    private func onAddPaymentMethodTapped() async -> Bool {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let response = await APIGatewayService.shared.privateCreatePaymentSetupIntent()
        switch response {
        case .success(let data):
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            guard let stripeCustomerId = data.stripeCustomerId, let setupIntentClientSecret = data.setupIntent, let ephemeralKey = data.ephemeralKey else { return false }
            
            self.launchStripeSetupIntent(customerId: stripeCustomerId, intentId: setupIntentClientSecret, ephemeralKey: ephemeralKey)
            
            return true
        case .failure(let error):
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return false
        }
    }
    
    func launchStripeSetupIntent(customerId: String, intentId: String, ephemeralKey: String) {
        
        
        var configuration = PaymentSheet.Configuration()
        configuration.merchantDisplayName = "Template"
        configuration.customer = .init(id: customerId, ephemeralKeySecret: ephemeralKey)
        configuration.allowsDelayedPaymentMethods = true
        paymentSheet = PaymentSheet(setupIntentClientSecret: intentId, configuration: configuration)
        DispatchQueue.main.async {
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first, let rootViewController = window.rootViewController else {
                // Handle the case where the window or windowScene is not available
                return
            }
            
            self.paymentSheet?.present(from: rootViewController) { paymentResult in
                switch paymentResult {
                case .completed:
                    Task {
                        await readPaymentMethods()
                    }
                case .canceled:
                    break
                case .failed(let error):
                    break
                }
            }
        }
    }
    
    func readPaymentMethods() async {
        let response = await APIGatewayService.shared.privateReadPaymentMethods()
        switch response {
        case .success(let data):
            paymentMethods = data.paymentMethods ?? []
        case .failure(let error):
            break
        }
    }
    
    func deletePaymentMethod(paymentMethodId: String) async {
        let body = DeletePaymentMethodRequest(accountId: UserRepo.shared.userPrivate?.user?.stripeAccountId , paymentMethodId: paymentMethodId)
        let response = await APIGatewayService.shared.privateDeletePaymentMethod(body: body)
        switch response {
        case .success(let data):
            self.paymentMethodId = ""
            self.showBottomSheet = false
        case .failure(let error):
            break
        }
    }
}
