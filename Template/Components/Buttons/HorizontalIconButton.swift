//
//  HorizontalIconButton.swift
//  Template
//
//  Created by Anthony Pham on 6/2/24.
//

import SwiftUI

struct HorizontalIconButton: View {
    var name: String
    var buttonText: String
    var action: () -> Void
    var isLabelOnly: Bool = false
    
//    let image = UIImage(named: model.icon)
//    icon.image = image

    var body: some View {
        VStack(spacing: 0) {
            Button(action: action) {
                HStack {
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 30, height: 30)
                    Spacer()
                        .frame(width: 30)
                    Text(buttonText)
                        .foregroundColor(.primary)
                    Spacer()
                    if !isLabelOnly {
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical)
            }
//            Divider()
//                .padding(.leading)
        }
        .background(Color.white)
    }
}
