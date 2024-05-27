//
//  LoadingButton.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

struct LoadingButton: View {
    
    @State var title: String = ""
    @Binding var isLoading: Bool
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .scaleEffect(1.0)
                    } else {
                        Text(title)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color.blue)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .disabled(isLoading) // Disable button while loading
            
            Spacer()
        }
    }
}

//struct LoadingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingButton()
//    }
//}
