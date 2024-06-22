//
//  PersonalInfoScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/9/24.
//

import AWSMobileClient
import SwiftUI

struct PersonalInfoScreen: View {
    
    @Binding var path: NavigationPath
    
    @State var isLoading: Bool = false
    
    @State var isLegalNameExpanded: Bool = false
    @State var isLegalNameEnabled: Bool = true
    @State var firstName: String = ""
    @State var lastName: String = ""
    
    @State var isPreferredNameExpanded: Bool = false
    @State var isPreferredNameEnabled: Bool = true
    @State var preferredName: String = ""
    
    @State var isPhoneNumberExpanded: Bool = false
    @State var isPhoneNumberEnabled: Bool = true
    @State var countryCode: String = ""
    @State var phoneNumber: String = ""
    @State var phoneNumberVerificationCode: [String] = ["", "", "", "", "", ""]
    
    @State var isEmailExpanded: Bool = false
    @State var isEmailEnabled: Bool = true
    @State var isEmailSaveEnabled: Bool = true
    @State var email: String = ""
    @State var emailVerificationCode: [String] = ["", "", "", "", "", ""]
    @State var isEmailVerificationCodePresented: Bool = false
    
    @State var isAddressExpanded: Bool = false
    @State var isAddressEnabled: Bool = true
    
    @State var isEmergencyContactExpanded: Bool = false
    @State var isEmergencyContactEnabled: Bool = true
    
    @State private var isScreenLoading: Bool = true
    
    var body: some View {
        if isScreenLoading {
            LoadingScreen()
                .onAppear {
                    Task {
                        await readUser()
                    }
                }
        } else {
            ScrollView {
                ExpandableView(isExpanded: $isLegalNameExpanded, isEnabled: $isLegalNameEnabled, title: "Legal name", openedTitle: "Edit", closedTitle: "Cancel") {
                    VStack(alignment: .leading) {
                        OutlinedTextField(title: "First name on ID", placeholder: "", text: $firstName)
                        OutlinedTextField(title: "Last name on ID", placeholder: "", text: $lastName)
                        Button("Save") {
                            Task {
                                let success = await updateLegalName(firstName: firstName, lastName: lastName)
                                if success {
                                    isLegalNameExpanded = false
                                }
                            }
                        }
                    }
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Legal name", isEnabled: value)
                }
                
                ExpandableView(isExpanded: $isPreferredNameExpanded, isEnabled: $isPreferredNameEnabled, title: "Preferred first name", openedTitle: "Edit", closedTitle: "Cancel") {
                    VStack(alignment: .leading) {
                        OutlinedTextField(title: "Preferred first name (optional)", placeholder: "", text: $preferredName)
                        Button("Save") {
                            Task {
                                let success = await updatePreferredName(preferredName: preferredName)
                                if success {
                                    isPreferredNameExpanded = false
                                }
                            }
                        }
                    }
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Preferred first name", isEnabled: value)
                }
                
                ExpandableView(isExpanded: $isPhoneNumberExpanded, isEnabled: $isPhoneNumberEnabled, title: "Phone number", openedTitle: "Edit", closedTitle: "Cancel") {
                    VStack(alignment: .leading) {

                        Button("Save") {
                            
                        }
                    }
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Phone number", isEnabled: value)
                }
                
                ExpandableView(isExpanded: $isEmailExpanded, isEnabled: $isEmailEnabled, title: "Email", openedTitle: "Edit", closedTitle: "Cancel") {
                    VStack(alignment: .leading) {

                        OutlinedTextField(title: "Email", placeholder: "", text: $email)
                        
                        LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isEmailSaveEnabled, action: {
                            isEmailExpanded = false
                            isEmailVerificationCodePresented = true
//                            Task {
//                                let success = await updateEmail(email: email)
//                                if success {
//                                    isEmailExpanded = false
//                                    isEmailVerificationCodePresented = true
//                                }
//                            }
                        })

                    }
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Email", isEnabled: value)
                }
                .sheet(isPresented: $isEmailVerificationCodePresented) {
                    
                    VStack {
                        CodeField(code: $emailVerificationCode)
                            .padding()
                        
                        Spacer()
                        
                        Divider()
                        
                        LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isEmailSaveEnabled, action: {
                            Task {
                                confirmEmailChange(verificationCode: emailVerificationCode.joined()) { response in
                                    isEmailVerificationCodePresented = false
                                }
                            }
                        })
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
            .onAppear {
                Task {
                    await readUser()
                }
            }
            .padding()
        }
    }
    
    
    private func updateEnabledAndDisabledSections(field: String, isEnabled: Bool) {
        switch field {
        case "Legal name":
            isPreferredNameEnabled = !isEnabled
            isPhoneNumberEnabled = !isEnabled
            isEmailEnabled = !isEnabled
            isAddressEnabled = !isEnabled
            isEmergencyContactEnabled = !isEnabled
        case "Preferred first name":
            isLegalNameEnabled = !isEnabled
            isPhoneNumberEnabled = !isEnabled
            isEmailEnabled = !isEnabled
            isAddressEnabled = !isEnabled
            isEmergencyContactEnabled = !isEnabled
        case "Phone number":
            isLegalNameEnabled = !isEnabled
            isPreferredNameEnabled = !isEnabled
            isEmailEnabled = !isEnabled
            isAddressEnabled = !isEnabled
            isEmergencyContactEnabled = !isEnabled
        case "Email":
            isLegalNameEnabled = !isEnabled
            isPreferredNameEnabled = !isEnabled
            isPhoneNumberEnabled = !isEnabled
            isAddressEnabled = !isEnabled
            isEmergencyContactEnabled = !isEnabled
        default:
            break
        }
    }
    
    private func readUser() async {
        let userSub = UserRepo.shared.userSub ?? ""
        let response = await APIGatewayService.shared.privateReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            firstName = data.firstName ?? ""
            lastName = data.lastName ?? ""
            preferredName = data.preferredName ?? ""
            email = data.email ?? ""
            isScreenLoading = false
        case .failure(_):
            isScreenLoading = false
            break
        }
    }
    
    private func updateLegalName(firstName: String, lastName: String) async -> Bool {
        var body = UpdateUserBody()
        body.updateLegalName = UpdateLegalName(firstName: firstName, lastName: lastName)
        let response = await executeUpdate(body: body)
        return response
    }
    
    private func updatePreferredName(preferredName: String) async -> Bool {
        var body = UpdateUserBody()
        body.updatePreferredName = UpdatePreferredName(preferredName: preferredName)
        let response = await executeUpdate(body: body)
        return response
    }
    
    private func updateEmail(email: String) async -> Bool {
        var body = UpdateUserBody()
        body.updateEmail = UpdateEmail(email: email)
        let response = await executeUpdate(body: body)
        return response
    }
    
    private func confirmEmailChange(verificationCode: String, onResult: @escaping (AWSMobileClientResponse<Void>) -> Void) {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        
        AWSMobileClient.default().confirmUpdateUserAttributes(attributeName: "email", code: verificationCode) { error in
            if let error = error {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                onResult(AWSMobileClientResponse<Void>(isSuccessful: false, result: nil, exception: error.localizedDescription))
            } else {
                DispatchQueue.main.async {
                    self.isLoading = false
                }
                onResult(AWSMobileClientResponse<Void>(isSuccessful: true, result: nil, exception: nil))
            }
        }
    }
    
    private func executeUpdate(body: UpdateUserBody) async -> Bool {
        let userSub = UserRepo.shared.userSub ?? ""
        let response = await APIGatewayService.shared.privateUpdateUser(userSub: userSub, body: body)
        switch response {
        case .success(let data):
            return true
        case .failure(let error):
            return false
        }
    }
}
