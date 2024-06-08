//
//  StepsGuideScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/6/24.
//

import SwiftUI

struct StepsGuideScreen: View {
    
    @Binding private var path: NavigationPath
    @State private var numberOfSteps: String = ""
    
    init(path: Binding<NavigationPath>) {
        self._path = path
    }
    
    var body: some View {
        VStack {
            Text("StepsGuideScreen")
                .navigationTitle("StepsGuideScreen")
            
            TextField("Number of steps", text: $numberOfSteps)
                .keyboardType(.phonePad)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
            Button(action: {
                
            }) {
                Text("Launch in screen")
            }
            
            
            Divider()
            
            Button(action: {
                
            }) {
                Text("Launch in bottom sheet")
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    DeltaScreen()
//}
