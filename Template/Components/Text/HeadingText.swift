//
//  HeadingText.swift
//  Template
//
//  Created by Anthony Pham on 6/17/24.
//

import SwiftUI

struct HeadingText: View {
    
    @State var title: String = ""
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

