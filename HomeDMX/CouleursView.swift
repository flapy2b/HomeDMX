//
//  CouleursView.swift
//  HomeDMX
//
//  Created by GUENIOT FLORIAN on 11/12/2025.
//

import SwiftUI

struct CouleursView: View {
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple, .orange]
    @State private var selectedColor: Color = .white
    
    var body: some View {
        ScrollView{
            Text("Couleurs")
                .font(.largeTitle)
                .padding()
            
            LazyVGrid(columns: [GridItem(.flexible(minimum: 100))]) {
                ForEach(colors, id: \.self) { color in
                    ColorPad(
                        color: color,
                        isSelected: color == selectedColor
                    )
                }
            }
        }
        
    }
}

#Preview {
    CouleursView()
}
