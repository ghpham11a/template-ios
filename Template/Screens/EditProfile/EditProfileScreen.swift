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
    @State private var isLoading = false
    
    @State private var schoolName = ""
    @State private var isSchoolExpanded = false
    @State private var isSchoolEnabled = true
    
    @State private var isEnabledPlaceholder = false
        
    @State private var userTags: [Tag] = []
    
    @State private var selectedTags: [Tag] = []
    
    @State private var selectableTags: [Tag] = [
        Tag(id: 1, title: "Alpha"),
        Tag(id: 2, title: "Bravo"),
        Tag(id: 3, title: "Charlie"),
        Tag(id: 4, title: "Delta"),
        Tag(id: 5, title: "Echo")
    ]
    @State private var showTagListSheet = false

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
                    LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: $isEnabledPlaceholder, action: {
                        Task {
                            let success = await updateSchool(schoolName: schoolName)
                            if success {
                                isSchoolExpanded = false
                            }
                        }
                    })
                }
                .padding()
                
            } onExpansionChanged: { value in
               
            }
            
            HeadingText(title: "Tags")
            
            TagList(tags: userTags)
            
            Button(action: {
                selectedTags = userTags
                showTagListSheet.toggle()
            }) {
                Text("Edit")
            }
            
        }
        .padding()
        .background(Color.clear)
        .onAppear {
            Task {
                await readUser()
            }
        }
        .sheet(isPresented: $showTagListSheet) {
            VStack {
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
                        Text("Edit tags")
                            .font(.headline)
                    }


                    List(selectableTags, id: \.id) { tag in
                        CheckboxRow(title: tag.title ?? "", isChecked: selectedTags.contains(tag)) { _ in
                            selectOrDeselectTag(tag: tag)
                        }
                    }
                }
                VStack {
                    LoadingButton(title: "Save", isLoading: $isLoading, isEnabled: true, action: {
                        Task {
                            var result = await updateTags(tags: selectedTags)
                            if result {
                                showTagListSheet.toggle()
                            }
                        }
                    })
                }
                .padding()
            }
            .presentationDetents([.fraction(0.75)])
        }
    }
    
    func tagTitleFromId(id: Int) -> String {
        switch id {
        case 1:
            return "Alpha"
        case 2:
            return "Bravo"
        case 3:
            return "Charlie"
        case 4:
            return "Delta"
        case 5:
            return "Echo"
        default:
            return ""
        }
    }
    
    func selectOrDeselectTag(tag: Tag) {
        if let index = selectedTags.firstIndex(where: { $0.id == tag.id }) {
            selectedTags.remove(at: index)
        } else {
            selectedTags.append(tag)
        }
    }
    
    private func readUser() async {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await UserRepo.shared.publicReadUser(userSub: userSub)
        switch response {
        case .success(let data):
            schoolName = data.schoolName ?? ""
            userTags = data.tags?.map { Tag(id: $0, title: tagTitleFromId(id: $0)) } ?? []
            selectedTags = userTags
        case .failure(_):
            break
        }
    }
    
    private func updateSchool(schoolName: String) async -> Bool {
        isLoading.toggle()
        var body = UpdateUserBody()
        body.updateSchool = UpdateSchool(schoolName: schoolName)
        let response = await executeUpdate(body: body)
        isLoading.toggle()
        return response
    }
    
    private func updateTags(tags: [Tag]) async -> Bool {
        isLoading.toggle()
        var body = UpdateUserBody()
        body.updateTags = UpdateTags(tags: tags.map { $0.id ?? -1 })
        let response = await executeUpdate(body: body)
        isLoading.toggle()
        if response {
            userTags = tags
        }
        return response
    }
    
    private func executeUpdate(body: UpdateUserBody) async -> Bool {
        let userSub = UserRepo.shared.userId ?? ""
        let response = await APIGatewayService.shared.privateUpdateUser(userSub: userSub, body: body)
        switch response {
        case .success(_):
            return true
        case .failure(_):
            return false
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



