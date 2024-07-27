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
    @Binding var isEnabled: Bool
    var action: () -> Void
    
    init(title: String, isLoading: Binding<Bool>, isEnabled: Binding<Bool>, action: @escaping () -> Void) {
        self.title = title
        self._isLoading = isLoading
        self._isEnabled = isEnabled
        self.action = action
    }
    
    init(title: String, isLoading: Bool, isEnabled: Binding<Bool>, action: @escaping () -> Void) {
        self.title = title
        self._isLoading = .constant(isLoading)
        self._isEnabled = isEnabled
        self.action = action
    }
    
    init(title: String, isLoading: Binding<Bool>, isEnabled: Bool, action: @escaping () -> Void) {
        self.title = title
        self._isLoading = isLoading
        self._isEnabled = .constant(isEnabled)
        self.action = action
    }
    
    init(title: String, isLoading: Bool, isEnabled: Bool, action: @escaping () -> Void) {
        self.title = title
        self._isLoading = .constant(isLoading)
        self._isEnabled = .constant(isEnabled)
        self.action = action
    }
    
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
                .frame(maxWidth: .infinity, minHeight: 50)
                .cornerRadius(10)
                .background((isLoading || !isEnabled) ? Color.gray : Color.blue)
            }
            .buttonStyle(PlainButtonStyle())
            .disabled(isLoading || !isEnabled)
        }
        .padding(0)
    }
}

//struct LoadingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingButton()
//    }
//}
