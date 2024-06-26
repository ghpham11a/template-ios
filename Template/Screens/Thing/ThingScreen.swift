//
//  StepsGuideScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/6/24.
//

import SwiftUI

struct ThingScreen: View {
    
    @Binding var path: NavigationPath
    @State var thingId: String
    
    @State private var numberOfSteps: String = ""
    @State private var showingBottomSheet: Bool = false
    
    @State private var isThingTypeChecked: Bool = false
    @State private var isThingDescriptionChecked: Bool = false
    @State private var isThingMethodsChecked: Bool = false
    @State private var isThingLocationChecked: Bool = false
    
    @State private var isLoading = false
    @State private var isEnabledPlaceholder: Bool = true
    
    var body: some View {
        ScrollView {
            
            Text(thingId)
        }
        .padding(.horizontal)
        .sheet(isPresented: $showingBottomSheet) {
            ThingBuilderScreen(path: $path, mode: "BOTTOM_SHEET", steps: getStepString(), backAction: {
                showingBottomSheet.toggle()
            })
                .presentationDetents([.large])
        }
    }
    
    private func getStepString() -> String {
        var steps = [String]()
        if isThingTypeChecked {
            steps.append(Constants.ThingScreen.THING_TYPE)
        }
        if isThingDescriptionChecked {
            steps.append(Constants.ThingScreen.THING_DESCRIPTION)
        }
        if isThingMethodsChecked {
            steps.append(Constants.ThingScreen.THING_METHODS)
        }
        
        return steps.joined(separator: ",")
    }
}

//#Preview {
//    DeltaScreen()
//}
