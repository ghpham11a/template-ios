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
    
    var stepsMap: [Int: String] {
        Dictionary(uniqueKeysWithValues: steps.components(separatedBy: ",").enumerated().map { ($0, $1)})
    }
    
    var body: some View {
        VStack {
            
            if mode == "BOTTOM_SHEET" {
                HStack {
                    Button(action: action) {
                        Text("Back")
                    }
                    Spacer()
                }
                .frame(alignment: .leading)
                .padding()
            }
            
            TabView(selection: $currentPage) {
                
                switch stepsMap[currentPage] {
                case Constants.ThingScreen.THING_TYPE:
                    ThingTypeScreen()
                case Constants.ThingScreen.THING_DESCRIPTION:
                    ThingDescriptionScreen()
                case Constants.ThingScreen.THING_METHODS:
                    ThingTypeScreen()
                default:
                    SnagScreen()
                }
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
