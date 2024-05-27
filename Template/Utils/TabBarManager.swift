//
//  Router.swift
//  Template
//
//  Created by Anthony Pham on 5/27/24.
//

import SwiftUI

class TabBarManager: ObservableObject {
    
    static let shared = TabBarManager()
    
    @Published var isToolBarVisible: Visibility = .visible
    
    var navigationStack = [String]()
    
    func replace() {
        navigationStack = []
        updateToolBar()
    }
    
    func push(url: String) {
        if !navigationStack.contains(url) {
            navigationStack.append(url)
            updateToolBar()
        }
    }
    
    func pop() {
        navigationStack.removeLast(1)
        updateToolBar()
    }
    
    private func updateToolBar() {
        DispatchQueue.main.async {
            self.isToolBarVisible = (self.navigationStack.count == 0) ? .visible : .hidden
        }
    }
}

//struct ExampleTabScreen: View {
//
//    var body: some View {
//        VStack {
//
//        }
//        .onAppear {
//            TabBarManager.shared.replace()
//        }
//    }
//}

//struct ExampleScreen: View {
//
//    var body: some View {
//        VStack {
//
//        }
//        .navigationBarTitle("ExampleScreen", displayMode: .inline)
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading: BackButton(icon: .remove))
//        .onAppear {
//            TabBarManager.shared.push(url: Constants.Route.AUTH_HUB)
//        }
//    }
//}
