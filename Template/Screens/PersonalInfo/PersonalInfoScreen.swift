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
    
    // Legal name
    @State var isLegalNameExpanded: Bool = false
    @State var isLegalNameEnabled: Bool = true
    @State var firstName: String = ""
    @State var firstNameField: String = ""
    @State var lastName: String = ""
    @State var lastNameField: String = ""
    
    // Preferred name
    @State var isPreferredNameExpanded: Bool = false
    @State var isPreferredNameEnabled: Bool = true
    @State var preferredName: String = ""
    @State var preferredNameField: String = ""
    
    // Phone number
    @State var isPhoneNumberExpanded: Bool = false
    @State var isPhoneNumberEnabled: Bool = true
    @State var countryCode: String = ""
    @State var countryCodeField: String = ""
    @State var phoneNumber: String = ""
    @State var phoneNumberField: String = ""
    @State var phoneNumberVerificationCode: [String] = ["", "", "", "", "", ""]
    
    // Email
    @State var isEmailExpanded: Bool = false
    @State var isEmailEnabled: Bool = true
    @State var isEmailSaveEnabled: Bool = true
    @State var email: String = ""
    @State var emailField: String = ""
    @State var emailVerificationCode: [String] = ["", "", "", "", "", ""]
    @State var isEmailVerificationCodePresented: Bool = false
    
    // Address
    @State var isAddressExpanded: Bool = false
    @State var isAddressEnabled: Bool = true
    
    // Emergency contact
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
                } closedContent: {
                    Text((firstName != "" && lastName != "") ? "\(firstName) \(lastName)" : "Not provided")
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Legal name", isEnabled: value)
                }
                
                ExpandableView(isExpanded: $isPreferredNameExpanded, isEnabled: $isPreferredNameEnabled, title: "Preferred first name", openedTitle: "Edit", closedTitle: "Cancel") {
                    
                    VStack(alignment: .leading) {
                        OutlinedTextField(title: "Preferred first name (optional)", placeholder: "", text: $preferredNameField)
                        
                        LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isPreferredNameEnabled, action: {
                            Task {
                                let success = await updatePreferredName(preferredName: preferredNameField)
                                if success {
                                    updateEnabledAndDisabledSections(field: "Preferred first name", isEnabled: false)
                                    isPreferredNameExpanded = false
                                }
                            }
                        })

                    }
                } closedContent: {
                    Text(preferredName != "" ? preferredName : "Not provided")
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Preferred first name", isEnabled: value)
                    preferredNameField = preferredName
                }
                
                ExpandableView(isExpanded: $isPhoneNumberExpanded, isEnabled: $isPhoneNumberEnabled, title: "Phone number", openedTitle: "Edit", closedTitle: "Cancel") {
                    VStack(alignment: .leading) {
                        
                        PhoneNumberField(selectedCountryCode: $countryCodeField, phoneNumber: $phoneNumberField)

                        LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isPhoneNumberEnabled, action: {
                            Task {
                                let success = await updatePhoneNumber(countryCode: countryCodeField, phoneNumber: phoneNumberField)
                                if success {
                                    isPhoneNumberExpanded = false
                                }
                            }
                        })
                    }
                } closedContent: {
                    if phoneNumberField != "" {
                        Text("\(phoneNumberField)")
                    } else {
                        Text("Update phone number")
                    }
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Phone number", isEnabled: value)
                }
                
                ExpandableView(isExpanded: $isEmailExpanded, isEnabled: $isEmailEnabled, title: "Email", openedTitle: "Edit", closedTitle: "Cancel") {
                    
                    @State var emailField = email
                    
                    VStack(alignment: .leading) {

                        OutlinedTextField(title: "Email", placeholder: "", text: $emailField)
                        
                        LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isEmailSaveEnabled, action: {
                            Task {
                                let success = await updateEmail(email: emailField)
                                if success {
                                    isEmailExpanded = false
                                    isEmailVerificationCodePresented = true
                                }
                            }
                        })

                    }
                } closedContent: {
                    Text(email != "" ? email : "Fill out your email")
                } onExpansionChanged: { value in
                    updateEnabledAndDisabledSections(field: "Email", isEnabled: value)
                }
                .sheet(isPresented: $isEmailVerificationCodePresented) {
                    
                    VStack {
                        CodeField(code: $emailVerificationCode)
                            .padding()
                        
                        Spacer()
                        
                        Divider()
                        
                        HStack {
                            LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isEmailSaveEnabled, action: {
                                Task {
                                    confirmEmailChange(verificationCode: emailVerificationCode.joined()) { response in
                                        isEmailVerificationCodePresented = false
                                    }
                                }
                            })
                        }
                        .padding()
                    }
                    .presentationDetents([.fraction(0.5)])
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
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.privateReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            firstName = UserRepo.shared.firstName ?? ""
            firstNameField = UserRepo.shared.firstName ?? ""
            lastName = UserRepo.shared.lastName ?? ""
            lastNameField = UserRepo.shared.lastName ?? ""
            preferredName = data.user?.preferredName ?? ""
            preferredNameField = data.user?.preferredName ?? ""
            
                
            
            countryCode = data.user?.countryCode ?? ""
            countryCodeField = "United States (+1)"
            
            
            phoneNumber = (data.user?.phoneNumber ?? "").replacingOccurrences(of: (data.user?.countryCode ?? ""), with: "")
            phoneNumberField = (data.user?.phoneNumber ?? "").replacingOccurrences(of: (data.user?.countryCode ?? ""), with: "")
            
            email = UserRepo.shared.username ?? ""
            emailField = UserRepo.shared.username ?? ""
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
        if response {
            self.firstName = firstName
            UserRepo.shared.updateUser(key: Constants.UserAttributes.FirstName, value: firstName)
            self.lastName = lastName
            UserRepo.shared.updateUser(key: Constants.UserAttributes.LastName, value: lastName)
        }
        return response
    }
    
    private func updatePreferredName(preferredName: String) async -> Bool {
        var body = UpdateUserBody()
        body.updatePreferredName = UpdatePreferredName(preferredName: preferredName)
        let response = await executeUpdate(body: body)
        if response {
            self.preferredName = preferredNameField
            UserRepo.shared.updateUser(key: Constants.UserAttributes.PreferredName, value: preferredNameField)
        }
        return response
    }
    
    private func updateEmail(email: String) async -> Bool {
        var body = UpdateUserBody()
        body.updateEmail = UpdateEmail(email: email)
        let response = await executeUpdate(body: body)
        return response
    }
    
    private func updatePhoneNumber(countryCode: String, phoneNumber: String) async -> Bool {
        var body = UpdateUserBody()
        var code = "+" + countryCode.filter({ $0.isNumber })
        body.updatePhoneNumber = UpdatePhoneNumber(countryCode: code, phoneNumber: code + phoneNumber, username: UserRepo.shared.userPrivate?.user?.email ?? "")
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
                UserRepo.shared.updateUser(key: Constants.USER_DEFAULTS_KEY_USERNAME, value: email)
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
        DispatchQueue.main.async {
            self.isLoading = true
        }
        let userSub = UserRepo.shared.userId ?? ""
        let response = await APIGatewayService.shared.privateUpdateUser(userSub: userSub, body: body)
        switch response {
        case .success(let data):
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return true
        case .failure(let error):
            DispatchQueue.main.async {
                self.isLoading = false
            }
            return false
        }
    }
}
