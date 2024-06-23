//
//  LoginAndSecurityScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/3/24.
//

import SwiftUI

struct LoginAndSecurityScreen: View {

    @Binding private var path: NavigationPath
    
    @StateObject private var viewModel = LoginAndSecurityViewModel()
    @State private var currentPassword: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    
    @State private var isPasswordExpanded: Bool = false
    @State private var isPasswordEnabled: Bool = true
    
    @State private var isEnabledPlaceholder: Bool = true
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        ScrollView {
            ExpandableView(isExpanded: $isPasswordExpanded, isEnabled: $isPasswordEnabled, title: "Password", openedTitle: "Edit", closedTitle: "Cancel") {
                VStack(alignment: .leading) {
                    TextField("Current password", text: $currentPassword)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    TextField("New password", text: $newPassword)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    TextField("Confirm password", text: $confirmPassword)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(5.0)
                        .padding(.bottom, 20)
                    Button("Save") {
                        
                        if newPassword != confirmPassword { return }
                        
                        viewModel.changePassword(currentPassword: currentPassword, proposedPassword: newPassword) { response in
                            DispatchQueue.main.async {
                                if response.isSuccessful == true {
                                    isPasswordExpanded.toggle()
                                } else {
                                    
                                }
                            }
                        }
                    }
                }
            } closedContent: {
                Text("Update your password")
            } onExpansionChanged: { value in
                
            }
            
            LoadingButton(title: "Deactivate Account", isLoading: $viewModel.isDisabling, isEnabled: $isEnabledPlaceholder, action: {
                Task {
                    let result = await viewModel.disableUser()
                    if result {
                        path = NavigationPath()
                    }
                }
            })
            
            LoadingButton(title: "Delete Account", isLoading: $viewModel.isDeleting, isEnabled: $isEnabledPlaceholder, action: {
                Task {
                    let result = await viewModel.deleteUser()
                    if result {
                        path = NavigationPath()
                    }
                }
            })
        }
        .padding()
    }
}
