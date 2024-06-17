//
//  ThingTypeScreen.swift
//  Template
//
//  Created by Anthony Pham on 6/9/24.
//

import SwiftUI

struct ThingTypeScreen: View {
    
    @StateObject var viewModel: ThingViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.availableThingTypes, id: \.title) { thingType in
                Button(action: {
                    viewModel.selectThingType(thingType: thingType)
                }) {
                    VStack(alignment: .leading) {
                        Text(thingType.title)
                        Spacer()
                        Text(thingType.description)
                    }
                }
            }
        }
        .navigationTitle("ThingTypeScreen \(viewModel.availableThingTypes.count)")
    }
}

