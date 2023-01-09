//
//  IconButton.swift
//  RandomFacts
//
//  Created by Sree Sai Raghava Dandu on 08/01/23.
//

import SwiftUI

enum IconPosition {
    case leading, trailing
}

struct IconButton: View {
    var icon: String
    var text: String
    var position: IconPosition
    var foregroundColor: Color = .white
    var backgroundColor: Color = .blue
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                if position == .leading {
                    Image(systemName: icon)
                        .font(.title)
                        .foregroundColor(foregroundColor)
                    Text(text)
                        .font(.headline)
                        .foregroundColor(foregroundColor)
                } else {
                    Text(text)
                        .font(.headline)
                        .foregroundColor(foregroundColor)
                    Image(systemName: icon)
                        .font(.title)
                        .foregroundColor(foregroundColor)
                }
            }
        }
        .padding(10)
        .background(backgroundColor)
        .cornerRadius(8)
        
    }
}

struct IconButton_Previews: PreviewProvider {
    static var previews: some View {
        IconButton(icon: "pencil", text: "Edit", position: .leading) {
            print("Button Tapped")
        }
    }
}
