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
                AsyncImage(url: URL(string: String(format: Constants.USER_IMAGE_URL, UserRepo.shared.userSub ?? ""))) { phase in
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
        }
        .background(Color.clear)
    }
}

