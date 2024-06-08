//
//  ResetLinkText.swift
//  Template
//
//  Created by Anthony Pham on 6/7/24.
//

import SwiftUI

struct ResetLinkText: UIViewRepresentable {
    
    @Binding private var path: NavigationPath
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = true
        textView.delegate = context.coordinator
    
        
        // Configure the attributed string
        let attributedString = NSMutableAttributedString(string: "Forgot your password? Reset it.")
        
        // Define the font
        let font = UIFont.systemFont(ofSize: 18) // Set the desired font size
        
        // Apply font to the entire string
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: attributedString.length))
        
        // Apply styles and link to "Click here"
        if let linkRange = attributedString.string.range(of: "Reset it") {
            let nsRange = NSRange(linkRange, in: attributedString.string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.blue, range: nsRange)
            // attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: nsRange)
            attributedString.addAttribute(.link, value: "https://www.asdffdsaasdffdsasd.com", range: nsRange)
        }
        
        textView.attributedText = attributedString
        
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        // No updates needed for this example
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(path: $path)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        
        @Binding private var path: NavigationPath
        
        init(path: Binding<NavigationPath>) {
            self._path = path
        }
        
        func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
            // Handle the link tap
            // UIApplication.shared.open(URL)
            path.append(Route.resetPassword)
            return false
        }
    }
}
