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
    case animations = "Animations"

    var icon: String {
        switch self {
        case .couleurs: return "paintpalette.fill"
        case .animations: return "film.fill"
        }
    }
}

struct ContentView: View {
    @State private var selectedTab: DMXTab = .couleurs
    
    var body: some View {
            //ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                Group {
                    // Contenu principal (change selon l'onglet)
                    switch selectedTab {
                    case .couleurs:
                        CouleursView()
                    case .animations:
                        AnimationsView()
                    }
                } .frame(maxWidth: .infinity, maxHeight: .infinity) // <-- Clé pour remplir l'espace

                

                // Menu en bas (effet liquid glass)
                HStack {
                    ForEach(DMXTab.allCases, id: \.self) { tab in
                        Spacer()
                        Button(action: {
                            selectedTab = tab
                        }) {
                            VStack {
                                Image(systemName: tab.icon)
                                Text(tab.rawValue)
                                    .font(.caption)
                            }
                            .foregroundColor(selectedTab == tab ? .blue : .gray)
                            .padding()
                        }
                        Spacer()
                    }
                }
                .frame(height: 60)
                .background(
                    VisualEffectView(effect: UIBlurEffect(style: .systemThinMaterialLight))
                        .cornerRadius(40)
                        .shadow(radius: 10)
                )
                .padding(.horizontal, 20)
                .padding(.bottom, 20)  // Espace en bas pour éviter que le menu touche le bord
            }
            .edgesIgnoringSafeArea(.bottom)
        }
}

// Effet de flou pour le menu (liquid glass)
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView()
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = effect
    }
}

#Preview {
    ContentView()
}
