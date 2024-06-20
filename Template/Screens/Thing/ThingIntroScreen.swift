//
//  ThingIntroScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/19/24.
//

import SwiftUI

struct ThingIntroScreen: View {
    
    @Binding var path: NavigationPath
    
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
            
            Toggle(isOn: $isThingTypeChecked) {
                Text("Thing type")
            }
            .toggleStyle(CheckboxToggleStyle())
            .onChange(of: isThingTypeChecked) { oldValue, newValue in
                
            }
            
            Toggle(isOn: $isThingDescriptionChecked) {
                Text("Thing description")
            }
            .toggleStyle(CheckboxToggleStyle())
            .onChange(of: isThingDescriptionChecked) { oldValue, newValue in

            }
            
            Toggle(isOn: $isThingMethodsChecked) {
                Text("Thing methods")
            }
            .toggleStyle(CheckboxToggleStyle())
            .onChange(of: isThingMethodsChecked) { oldValue, newValue in

            }
            
            LoadingButton(title: "Launch in screen", isLoading: $isLoading, isEnabled: $isEnabledPlaceholder, action: {
                path.append(Route.thingBuilder(thingId: "NULL", action: "CREATE", mode: "SHEET", steps: getStepString()))
            })
            
            
            Divider()
            
            LoadingButton(title: "Launch in bottom sheet", isLoading: $isLoading, isEnabled: $isEnabledPlaceholder, action: {
                showingBottomSheet.toggle()
            })
            
            Spacer()
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

