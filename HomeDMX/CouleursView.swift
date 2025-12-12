import SwiftUI

struct CouleursView: View {
    // Tableau des couleurs DMX (nom + valeur hexadécimale)
    let couleursDMX: [(nom: String, couleur: Color)] = [
        ("Blanc", .white),
        ("Noir", .black),
        ("Rouge", .red),
        ("Vert", .green),
        ("Bleu", .blue),
        ("Orange", .orange),
        ("Violet", .purple),
        ("Jaune", .yellow)
    ]

    var body: some View {
        VStack {
            // Titre

            Spacer()

            // Grille de 2 colonnes et 4 lignes
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                ForEach(0..<couleursDMX.count, id: \.self) { index in
                    Button(action: {
                        // Action au clic : envoyer la couleur au DMX
                        envoyerCouleurDMX(couleur: couleursDMX[index].nom)
                    }) {
                        VStack {
                            // Carré coloré
                            RoundedRectangle(cornerRadius: 10)
                                .fill(couleursDMX[index].couleur)
                                .frame(width: 100, height: 100)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 2)
                                )
                            // Nom de la couleur
                            Text(couleursDMX[index].nom)
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }

    // Fonction pour envoyer la couleur au DMX
    func envoyerCouleurDMX(couleur: String) {
        print("Couleur sélectionnée : \(couleur)")
        // Ici, tu appelles ton API ou ta logique pour envoyer la commande DMX
        // Exemple : DMXManager.shared.envoyerCouleur(couleur)
    }
}

#Preview {
    CouleursView()
}
