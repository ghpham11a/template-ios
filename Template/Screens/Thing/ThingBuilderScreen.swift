//
//  ThingBuilderScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/6/24.
//

import SwiftUI

struct NonScrollable: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onAppear {
                UIScrollView.appearance().isScrollEnabled = false
            }
            .onDisappear {
                UIScrollView.appearance().isScrollEnabled = true
            }
    }
}

struct ThingBuilderScreen: View {
    
    @Binding var path: NavigationPath
    @State var mode: String = ""
    @State var steps: String = ""
    var action: () -> Void
    
    @State private var currentPage = 0
    
    var pageCount: Int {
        steps.split(separator: ",").count
    }
    
    var body: some View {
        VStack {
            
            HStack {
                Button(action: action) {
                    Text("Back")
                }
            }
            
            TabView(selection: $currentPage) {
                StepView(stepNumber: 1, stepDescription: "Step 1: Introduction")
                    .tag(0)
                StepView(stepNumber: 2, stepDescription: "Step 2: Details")
                    .tag(1)
                StepView(stepNumber: 3, stepDescription: "Step 3: Confirmation")
                    .tag(2)
                StepView(stepNumber: 4, stepDescription: "Step 4: Confirmation")
                    .tag(3)
                StepView(stepNumber: 5, stepDescription: "Step 5: Confirmation")
                    .tag(4)
                StepView(stepNumber: 6, stepDescription: "Step 6: Confirmation")
                    .tag(5)
                StepView(stepNumber: 7, stepDescription: "Step 7: Confirmation")
                    .tag(6)
                StepView(stepNumber: 8, stepDescription: "Step 8: Confirmation")
                    .tag(7)
                StepView(stepNumber: 9, stepDescription: "Step 9: Confirmation")
                    .tag(8)
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle())
            .modifier(NonScrollable())
            
            HStack(spacing: 8) {
                ForEach(0..<pageCount, id: \.self) { i in
                    Rectangle()
                        .fill(i <= currentPage ? Color.blue : Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 5)
                }
            }
            
            HStack {
                if currentPage > 0 {
                    Button(action: {
                        withAnimation {
                            currentPage -= 1
                        }
                    }) {
                        Text("Previous")
                    }
                } else {
                    Spacer().frame(width: 80)
                }
                
                Spacer()
                
                if currentPage < (steps.split(separator: ",").count - 1) {
                    Button(action: {
                        withAnimation {
                            currentPage += 1
                        }
                    }) {
                        Text("Next")
                    }
                } else {
                    Button(action: {
           
                    }) {
                        Text("Save")
                    }
                }
            }
            .padding()
        }
    }
}

struct StepView: View {
    let stepNumber: Int
    let stepDescription: String
    
    var body: some View {
        VStack {
            Text("Step \(stepNumber)")
                .font(.largeTitle)
                .padding()
            Text(stepDescription)
                .font(.body)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding()
    }
}

//#Preview {
//    ThingBuilderScreen()
//}
