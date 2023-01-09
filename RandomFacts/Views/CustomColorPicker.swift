//
//  CustomColorPicker.swift
//  RandomFacts
//
//  Created by Sree Sai Raghava Dandu on 08/01/23.
//

import SwiftUI

struct CustomColorPicker: View {
    @Binding var selectedColor: Color
    private let colors: [Color] = [.red, .yellow, .orange, .purple, .blue, .indigo, .green, .mint, .black, .white]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(colors, id:\.self) { color in
                    Circle()
                        .foregroundColor(color)
                        .frame(width: 45, height: 45)
                        .opacity(color == selectedColor ? 0.5 : 1.0)
                        .scaleEffect(color == selectedColor ? 1.2 : 1.0)
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
            .padding()
        }
    }
}

struct CustomColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        CustomColorPicker(selectedColor: .constant(.blue))
    }
}
