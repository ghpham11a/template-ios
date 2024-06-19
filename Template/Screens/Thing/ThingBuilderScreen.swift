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
    @State var thingId: String = ""
    @State var action: String = ""
    @State var mode: String = ""
    @State var steps: String = ""
    var backAction: () -> Void
    
    @StateObject private var viewModel = ThingViewModel()
    
    @State var loadingPlaceholder = false
    @State var enabledPlaceholder = true
    
    var stepsMap: [Int: String] {
        Dictionary(uniqueKeysWithValues: steps.components(separatedBy: ",").enumerated().map { ($0, $1)})
    }
    
    var body: some View {
        VStack {
            
            if mode == "BOTTOM_SHEET" {
                HStack {
                    Button(action: backAction) {
                        Text("Back")
                    }
                    Spacer()
                }
                .frame(alignment: .leading)
                .padding()
            }
            
            TabView(selection: $viewModel.currentPage) {
                
                switch stepsMap[viewModel.currentPage] {
                case Constants.ThingScreen.THING_TYPE:
                    ThingTypeScreen(viewModel: viewModel)
                case Constants.ThingScreen.THING_DESCRIPTION:
                    ThingDescriptionScreen(viewModel: viewModel)
                case Constants.ThingScreen.THING_METHODS:
                    ThingDescriptionScreen(viewModel: viewModel)
                default:
                    SnagScreen()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle())
            .modifier(NonScrollable())
            
            HStack(spacing: 8) {
                ForEach(0..<viewModel.pageCount, id: \.self) { i in
                    Rectangle()
                        .fill(i <= viewModel.currentPage ? Color.blue : Color.gray)
                        .frame(maxWidth: .infinity, maxHeight: 5)
                }
            }
            
            HStack {
                if viewModel.currentPage > 0 {
                    LoadingButton(title: "Previous", isLoading: $loadingPlaceholder, isEnabled: $enabledPlaceholder, action: {
                        withAnimation {
                            viewModel.updateCurrentPage(currentPage: viewModel.currentPage - 1)
                        }
                    })
                } else {
                    Spacer().frame(width: 80)
                }
                
                Spacer()
                
                if viewModel.currentPage < (viewModel.pageCount - 1) {
                    LoadingButton(title: "Next", isLoading: $loadingPlaceholder, isEnabled: $viewModel.isNextEnabled, action: {
                        withAnimation {
                            viewModel.updateCurrentPage(currentPage: viewModel.currentPage + 1)
                        }
                    })
                } else {
                    LoadingButton(title: "Save", isLoading: $viewModel.isLoading, isEnabled: $viewModel.isSaveEnabled, action: {
                        Task {
                            let success = await viewModel.saveThing()
                            if success {
                                path.removeLast(path.count)
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    path.append(Route.thing(thingId: "new"))
                                }
                            }
                        }
                    })
                }
            }
            .padding()
            .onAppear {
                viewModel.udpatePageCount(pageCount: steps.split(separator: ",").count)
            }
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
