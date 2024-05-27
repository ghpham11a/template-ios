//
//  Router.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

class Router: ObservableObject {
    
    static let shared = Router()
    
    @Published var isToolBarVisible: Visibility = .visible
    
    var navigationStack = [String]()
    
    func replace(url: String) {
        navigationStack = [url]
        updateToolBar()
    }
    
    func push(url: String) {
        navigationStack.append(url)
        updateToolBar()
    }
    
    func pop() {
        _ = navigationStack.removeLast()
        updateToolBar()
    }
    
    private func updateToolBar() {
        DispatchQueue.main.async {
            self.isToolBarVisible = (self.navigationStack.count == 1) ? .visible : .hidden
        }
    }
}
