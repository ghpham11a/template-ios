//
//  UIKitViewScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import SwiftUI
import UIKit

struct UIKitViewControllerRepresentable: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIKitViewController()
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // Update the UIViewController if needed
    }
}

struct UIKitViewScreen: View {
    
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            Text("This is a SwiftUI Text")
            UIKitViewControllerRepresentable()
                .frame(height: 200)
        }
    }
}
