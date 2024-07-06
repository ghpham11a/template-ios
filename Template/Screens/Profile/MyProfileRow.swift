//
//  MyProfileRow.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//
import SwiftUI

struct MyProfileRow: View {
    
    @StateObject private var userRepo = UserRepo.shared
    
    var title: String
    var subtitle: String
    var action: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    
                    AsyncImage(url: URL(string: String(format: Constants.USER_IMAGE_URL, userRepo.userId ?? ""))) { phase in
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
                    .id(userRepo.imageRefreshId)
                    .clipShape(.circle)
                    .frame(width: 40, height: 40)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .foregroundColor(.primary)
                        if subtitle != "" {
                            Text(subtitle)
                                .foregroundColor(.primary)
                        }
                    }

                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding(.vertical)
            }
            Divider()
                .padding(.leading)
        }
        .background(Color.white)
    }
}
