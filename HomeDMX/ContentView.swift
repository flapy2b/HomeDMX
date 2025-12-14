//
//  ContentView.swift
//  HomeDMX
//
//  Created by GUENIOT FLORIAN on 11/12/2025.
//

import SwiftUI

// Enum pour les onglets
enum DMXTab: String, CaseIterable {
    case couleurs = "Couleurs"
    case picker = "Picker"
    case animations = "Animations"

    var icon: String {
        switch self {
        case .couleurs: return "paintpalette.fill"
        case .picker: return "pencil.and.outline"
        case .animations: return "film.fill"
        }
    }
}

struct ContentView: View {
    @State private var selected = 0
    @State private var hue: Double = 0.5
    @State private var saturation: Double = 0.8
    @State private var selectedColor: Color = .white

    var body: some View {
        Header()
        ZStack(alignment: .bottom) {
            
            Group {
                switch selected{
                case 0: CouleursView()
                case 1: AnimationsView()
                default: ColorWheelView(hue: $hue, saturation: $saturation, selectedColor: $selectedColor)
                }
                
                /*
                if selected == 0 { CouleursView() }
                else { AnimationsView() }
                 */
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            LiquidGlassTabBar(selected: $selected)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

#Preview {
    ContentView()
}
