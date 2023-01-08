//
//  FactCard.swift
//  RandomFacts
//
//  Created by Sree Sai Raghava Dandu on 08/01/23.
//

import SwiftUI
import UIKit

struct FactCard: View {
    @Binding var fact:String
    @Binding var backgroundColor: Color
    @State private var isColorPickerShown = false
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(backgroundColor)
            VStack(alignment: .leading) {
                Text(fact)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
            }
        }
        .onTapGesture {
            self.isColorPickerShown.toggle()
        }
        .sheet(isPresented: $isColorPickerShown) {
            ColorPicker("Select a background color", selection: self.$backgroundColor)
                .onDisappear {
                    self.isColorPickerShown = false
                }
        }
    }
}

extension FactCard {
    func asImage() -> UIImage {
        let width = UIScreen.main.bounds.size.width - 40
        let height = UIScreen.main.bounds.size.height/2 
        let controller = UIHostingController(rootView: self)
        controller.view.frame = CGRect(x: 0, y: height/2, width: width, height: height)
        let imageSize = controller.view.bounds.size
        let renderer = UIGraphicsImageRenderer(size: imageSize)
        let image = renderer.image { context in
            controller.view.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
            // Add watermark
            let watermarkText = "Generated using © Learn You Desire"
            let watermarkAttributes = [
                            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                            NSAttributedString.Key.foregroundColor: UIColor.darkGray
                        ]
                        let watermarkSize = watermarkText.size(withAttributes: watermarkAttributes)
                        let watermarkRect = CGRect(x: imageSize.width - watermarkSize.width - 10,
                                                   y: imageSize.height - watermarkSize.height - 10,
                                                   width: watermarkSize.width,
                                                   height: watermarkSize.height)
                        watermarkText.draw(in: watermarkRect, withAttributes: watermarkAttributes)
        }
        return image
    }
}

