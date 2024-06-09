//
//  StepsGuideScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/6/24.
//

import SwiftUI

struct ThingScreen: View {
    
    @Binding private var path: NavigationPath
    @State private var numberOfSteps: String = ""
    @State private var showingBottomSheet: Bool = false
    
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
                path.append(Route.thingBuilder(mode: "SHEET", steps: getStepString(stepCount: numberOfSteps)))
            }) {
                Text("Launch in screen")
            }
            
            
            Divider()
            
            Button(action: {
                showingBottomSheet.toggle()
            }) {
                Text("Launch in bottom sheet")
            }
            
            Spacer()
        }
        .padding(.horizontal)
        .sheet(isPresented: $showingBottomSheet) {
            ThingBuilderScreen(path: $path, mode: "BOTTOM_SHEET", steps: getStepString(stepCount: numberOfSteps), action: {
                showingBottomSheet.toggle()
            })
                .presentationDetents([.large])
        }
    }
    
    private func getStepString(stepCount: String) -> String {
        if let stepCountInt = Int(stepCount) {
            let stepArray = Array(0..<stepCountInt)
            return stepArray.map { String($0) }.joined(separator: ",")
        } else {
            return ""
        }
    }
}

//#Preview {
//    DeltaScreen()
//}
