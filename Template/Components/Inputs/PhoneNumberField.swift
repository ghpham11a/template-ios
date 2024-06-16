//
//  PhoneNumberField.swift
//  Template
//
//  Created by Anthony Pham on 6/14/24.
//

import SwiftUI


struct PhoneNumberField: View {
    
    @Binding var selectedCountryCode: String
    @Binding var phoneNumber: String
    @State private var showCountryCodeSheet = false
    
    let countryCodes = ["United States ( +1 )", "India ( +91 )", "Isle of Man ( +44 )", "Australia ( +61 )", "Japan ( +81 )"]
    
    var body: some View {
        VStack(spacing: 16) {
            Button(action: {
                self.showCountryCodeSheet = true
            }) {
                HStack {
                    Text(selectedCountryCode)
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

            TextField("Phone Number", text: $phoneNumber)
                .keyboardType(.phonePad)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        .sheet(isPresented: $showCountryCodeSheet) {
            CountryCodeSheet(selectedCountryCode: $selectedCountryCode, countryCodes: countryCodes)
        }
    }
}

struct CountryCodeSheet: View {
    @Binding var selectedCountryCode: String
    let countryCodes: [String]

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


            List(countryCodes, id: \.self) { code in
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
