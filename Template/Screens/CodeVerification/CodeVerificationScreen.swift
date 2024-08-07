//
//  CodeVerificationScreen.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

struct CodeVerificationScreen: View {
    
    @Binding private var path: NavigationPath
    @StateObject private var viewModel = CodeVerificationViewModel()
    @State private var username: String
    @State private var password: String
    @State private var verificationType: String
    
    @State private var isEnabledPlaceholder: Bool = true
    
    init(path: Binding<NavigationPath>, verificationType: String, username: String, password: String) {
        self._path = path
        self.verificationType = verificationType
        self.username = username
        self.password = password
    }
    
    @State private var code: [String] = Array(repeating: "", count: 6)
    @FocusState private var focusedField: Int?

    var body: some View {
        ScrollView {
            HStack(spacing: 10) {
                ForEach(0..<6, id: \.self) { index in
                    TextField("", text: $code[index])
                        .frame(width: 40, height: 40)
                        .multilineTextAlignment(.center)
                        .keyboardType(.numberPad)
                        .focused($focusedField, equals: index)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: code[index]) { _, newValue in
                            if newValue.count == 1 {
                                moveToNextField(from: index)
                            } else if newValue.isEmpty {
                                moveToPreviousField(from: index)
                            }
                        }
                        .onReceive(NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification)) { notification in
                            if let textField = notification.object as? UITextField, let text = textField.text {
                                if text.isEmpty {
                                    moveToPreviousField(from: index)
                                }
                            }
                        }
                }
            }
            
            Spacer()
            
            LoadingButton(title: "Resend Code", isLoading: $viewModel.isLoading, isEnabled: $isEnabledPlaceholder, action: {
                Task {
                    viewModel.resendConfirmationCode(username: username) { response in
                        if response.isSuccessful == true {
                            
                        }
                    }
                }
            })
            
            Spacer()
            
            LoadingButton(title: "Submit", isLoading: $viewModel.isLoading, isEnabled: $isEnabledPlaceholder, action: {
                Task {
                    if verificationType == "SIGN_UP" {
                        viewModel.confirmSignUp(username: username, password: password, confirmationCode: code.joined()) { response in
                            DispatchQueue.main.async {
                                if response.isSuccessful == true {
                                    path = NavigationPath()
                                } else {
                                    path = NavigationPath()
                                    path.append(Route.snag)
                                }
                            }
                        }
                    }
                    if verificationType == "RESET_PASSWORD" {
                        path.append(Route.newPassword(username: username, code: code.joined()))
                    }
                }
            })

        }
        .padding()
        .onAppear {
            focusedField = 0
        }
    }

    private func moveToNextField(from index: Int) {
        if index < 5 {
            focusedField = index + 1
        } else {
            focusedField = nil // or any other action when the last field is filled
        }
    }

    private func moveToPreviousField(from index: Int) {
        if index > 0 {
            focusedField = index - 1
        } else {
            focusedField = nil // or any other action when the first field is empty
        }
    }
}

//struct CodeVerificationScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        CodeVerificationScreen()
//    }
//}

