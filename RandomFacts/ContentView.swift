//
//  ContentView.swift
//  RandomFacts
//
//  Created by Sree Sai Raghava Dandu on 08/01/23.
//

import SwiftUI
import UIKit

struct ContentView: View {
    @State private var facts:[String] = []
    @State private var currentFact: String = ""
    @State private var showSuccessAlert = false
    @State private var backgroundColor = Color.blue
    var body: some View {
        GeometryReader { reader in
            VStack {
                Text("Random Fact Generator")
                    .font(.headline)
                FactCard(fact: $currentFact, backgroundColor: $backgroundColor)
                    .frame(width: reader.size.width - 40, height: reader.size.height/2)
                    .padding([.horizontal,.vertical],20)
                HStack {
                    CustomColorPicker(selectedColor: $backgroundColor)
                }
                .background(.thinMaterial)
                .cornerRadius(20)
                .padding(.horizontal)
                HStack(spacing:10){
                    
                    IconButton(icon: "arrow.down.circle", text: "Save", position: .trailing) {
                        generateImageWithWatermark()
                    }
                    .alert(isPresented: $showSuccessAlert) {
                        Alert(title: Text("Success"), message: Text("The image was saved to your photos."), dismissButton: .default(Text("OK")))
                    }
                    IconButton(icon: "arrowshape.turn.up.right.circle", text: "Next", position: .trailing) {
                        updateFacts()
                    }
                }
                .padding()


            } .onAppear {
                loadFacts()
                updateFacts()
            }
        }
    }
    
    private func updateFacts() {
        self.currentFact = self.facts.randomElement() ?? "No Random Facts available"
    }
    
    private func loadFacts(){
        if let url = Bundle.main.url(forResource: "facts", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonFacts = try decoder.decode([String].self, from: data)
                self.facts = jsonFacts
            } catch {
                print("Error in loading facts: \(error)")
            }
        }
    }
    
    private func generateImageWithWatermark() {
        let image = FactCard(fact: $currentFact, backgroundColor: $backgroundColor).asImage()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.showSuccessAlert = true
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
