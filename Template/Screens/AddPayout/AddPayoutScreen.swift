//
//  AddPayoutScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/29/24.
//

import SwiftUI

struct PayoutType: Identifiable {
    var id = UUID()
    var title: String
}

struct AddPayoutScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var selectedCountry: String = "United States"
    @State private var showCountrySheet = false
    @State var isLoading = false
    @State var isContinueEnabled = true
    
    let countryList = ["United States", "India", "Isle of Man", "Australia", "Japan"]
    
    @State private var availablePayoutTypes: [PayoutType] = [
        PayoutType(title: "Bank Account")
    ]

    
    var body: some View {
        ScrollView {
            Text("Let's add a payout methods")
            
            Text("To start, let us know where you like us to send your money")
            
            Text("Billing country/region")
            
            Button(action: {
                self.showCountrySheet = true
            }) {
                HStack {
                    Text(selectedCountry)
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            }
            
            Text("This is where you opened your financial account")
            
            Text("How would you like to get paid?")
            
            Text("Payouts will be sent in USD")
            
            ForEach(availablePayoutTypes) { payoutType in
                Button(action: {
                    // viewModel.selectThingType(thingType: thingType)
                }) {
                    VStack(alignment: .leading) {
                        Text(payoutType.title)
                    }
                }
                .padding()
            }
            
            LoadingButton(title: "Continue", isLoading: $isLoading, isEnabled: $isContinueEnabled, action: {
                Task {
                    await onContinue()
                }
            })
            
        }
        .sheet(isPresented: $showCountrySheet) {
            CountrySheet(selectedCountryCode: $selectedCountry, countryList: countryList)
        }
        .padding()
    }
    
    private func onContinue() async {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        let body = CreatePayoutMethodRequest(route: "hosted_manual_entry", customerId: UserRepo.shared.userPrivate?.stripeCustomerId ?? "", accountId: UserRepo.shared.userPrivate?.stripeConnectedAccountId ?? "")
        let response = await APIGatewayService.shared.privateCreatePayoutMethod(body: body)
        switch response {
        case .success(let data):
            DispatchQueue.main.async {
                self.isLoading = false
            }
            print("__DEBUG \(data.url)")
        case .failure(let error):
            DispatchQueue.main.async {
                self.isLoading = false
            }
        }
    }
}

struct CountrySheet: View {
    @Binding var selectedCountryCode: String
    let countryList: [String]

    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button(action: {
                        exit()
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .imageScale(.large)
                    }
                    .padding()
                    Spacer()
                }
                Text("Select Country Code")
                    .font(.headline)
            }


            List(countryList, id: \.self) { code in
                Button(action: {
                    selectedCountryCode = code
                    // Dismiss the sheet
                    exit()
                }) {
                    Text(code)
                        .foregroundColor(.black)
                }
            }
        }
    }
    
    func exit() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            if let rootViewController = scene.windows.first(where: { $0.isKeyWindow })?.rootViewController {
                rootViewController.dismiss(animated: true, completion: nil)
            }
        }
    }
}
