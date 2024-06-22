//
//  EditProfileScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import SwiftUI

struct EditProfileScreen: View {
    
    @Binding private var path: NavigationPath
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented = false
    @StateObject private var viewModel = EditProfileViewModel()
    
    @State private var schoolName = ""
    @State private var isSchoolExpanded = false
    @State private var isSchoolEnabled = true
    @State private var isSchoolFieldLoading = false
    
    @State private var isEnabledPlaceholder = false

    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        ScrollView {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(.circle)
                    .listRowBackground(Color.clear)
            } else {
                AsyncImage(url: URL(string: String(format: Constants.USER_IMAGE_URL, UserRepo.shared.userId ?? ""))) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    case .failure:
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    @unknown default:
                        EmptyView()
                    }
                }
                .scaledToFit()
                .clipShape(.circle)
                .frame(width: 150, height: 150)
                .listRowBackground(Color.clear)
            }

            Button(action: {
                isImagePickerPresented = true
            }) {
                Text("Select Profile Photo")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .listRowBackground(Color.clear)
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(image: $image)
                    .onDisappear{
                        if self.image != nil {
                            Task {
                                let result = await self.viewModel.updateImage(image: self.image)
                                if !result {
                                    self.image = nil
                                } else {
                                    DispatchQueue.main.async {
                                        UserRepo.shared.imageRefreshId = UUID().uuidString
                                    }
                                }
                            }
                        }
                    }
                
            }
            
            BottomsheetField(isExpanded: $isSchoolExpanded, isEnabled: $isSchoolEnabled, title: "Where I went to school\(schoolName != "" ? ": \(schoolName)" : "")") {
                
                VStack {
                    OutlinedTextField(title: "Where I went to school",  placeholder: "", text: $schoolName)
                }
                .padding()
                
                Spacer()
                
                Divider()
                
                VStack {
                    LoadingButton(title: "Save", isLoading: $isSchoolFieldLoading, isEnabled: $isEnabledPlaceholder, action: {
                        isSchoolFieldLoading.toggle()
                        Task {
                            let success = await updateSchool(schoolName: schoolName)
                            if success {
                                isSchoolFieldLoading = false
                                isSchoolExpanded = false
                            }
                        }
                    })
                }
                .padding()
                
            } onExpansionChanged: { value in
               
            }
            
        }
        .background(Color.clear)
        .onAppear {
            Task {
                await readUser()
            }
        }
    }
    
    private func readUser() async {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.publicReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            schoolName = data.schoolName ?? ""
        case .failure(let error):
            break
        }
    }
    
    private func updateSchool(schoolName: String) async -> Bool {
        var body = UpdateUserBody()
        body.updateSchool = UpdateSchool(schoolName: schoolName)
        let response = await executeUpdate(body: body)
        return response
    }
    
    private func executeUpdate(body: UpdateUserBody) async -> Bool {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await APIGatewayService.shared.privateUpdateUser(userSub: userSub, body: body)
        switch response {
        case .success(let data):
            return true
        case .failure(let error):
            return false
        }
    }
}



