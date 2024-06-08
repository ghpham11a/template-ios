//
//  AuthHubScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/26/24.
//

import SwiftUI


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

struct AuthHubScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = AuthHubViewModel()
    @State private var isPhoneNumberMode: Bool = false
    
    @State private var selectedCountryCode = "+1"
    @State private var phoneNumber = ""
    @State private var showCountryCodeSheet = false

    let countryCodes = ["United States ( +1 )", "India ( +91 )", "Isle of Man ( +44 )", "Australia ( +61 )", "Japan ( +81 )"]
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }

    var body: some View {
        VStack {
            Text("Login or sign up")
            
            // ResetLinkText(path: $path)
            
            if !isPhoneNumberMode {
                
                TextField("Username", text: $viewModel.username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(5.0)
                    .padding(.bottom, 20)
                
                LoadingButton(title: "Continue", isLoading: $viewModel.isLoading, action: {
                    Task {
                        let result = await viewModel.checkIfUserExists()
                        if result.isSuccessful {
                            switch result.userStatus {
                            case .existsAndEnabled:
                                path.append(Route.authEnterPassword(username: viewModel.username, status: "enabled"))
                            case .existsAndDisabled:
                                path.append(Route.authEnterPassword(username: viewModel.username, status: "disabled"))
                            case .doesNotExist:
                                path.append(Route.authAddInfo(username: viewModel.username))

                            }
                        } else {
                            path = NavigationPath([Route.snag])
                        }
                    }
                })
                
                HStack {
                    Text("Forgot your password? ")
                        .padding(0)
                    Text("Reset it.")
                        .padding(0)
                        .offset(CGSize(width: -5, height: 0))
                        .onTapGesture {
                            path.append(Route.resetPassword)
                        }
                }
                .frame(alignment: .center)
                
            } else {
                
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

                    Button(action: {
                        // Handle form submission
                        print("Country Code: \(selectedCountryCode), Phone Number: \(phoneNumber)")
                    }) {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .sheet(isPresented: $showCountryCodeSheet) {
                    CountryCodeSheet(selectedCountryCode: $selectedCountryCode, countryCodes: countryCodes)
                }
            }
            
            Divider()
            
            if isPhoneNumberMode {
                OutlinedButton(
                    text: "Continue with Email",
                    iconName: "star",
                    action: {
                        isPhoneNumberMode = !isPhoneNumberMode
                    }
                )
            } else {
                OutlinedButton(
                    text: "Continue with Phone",
                    iconName: "star",
                    action: {
                        isPhoneNumberMode = !isPhoneNumberMode
                    }
                )
            }
            
            Spacer()
        }
        .frame(alignment: .top)
        .padding(.horizontal)
    }
    
    private var attributedString: AttributedString {
        var attributedString = AttributedString("Forgot your password? Reset it.")
        
        if let range = attributedString.range(of: "Reset it") {
            attributedString[range].foregroundColor = .blue
            attributedString[range].underlineStyle = .single
        }
        
        return attributedString
    }
}

//struct AuthHubScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        AuthHubScreen()
//    }
//}
