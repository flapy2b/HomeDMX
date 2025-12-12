import SwiftUI

struct ColorWheelView: View {
    @Binding var hue: Double
    @Binding var saturation: Double
    @Binding var selectedColor: Color  // Ajout d'un Binding pour la couleur sélectionnée
    @State private var isDragging = false

    var body: some View {
        VStack(spacing: 20) {
            // Barre d'aperçu de la couleur sélectionnée
            ColorPreviewBar(hue: hue, saturation: saturation, selectedColor: $selectedColor)
                .padding(.horizontal, 20)
            
            // Sélecteur de couleur circulaire
            GeometryReader { geometry in
                let radius = min(geometry.size.width, geometry.size.height) / 2
                let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

                ZStack {
                    // Gradient de couleur
                    AngularGradient(
                        gradient: Gradient(colors: [
                            .red, .yellow, .green, .mint, .blue, .purple, .red
                        ]),
                        center: .center
                    )
                    .mask(Circle())

                    // Dégradé de saturation
                    RadialGradient(
                        gradient: Gradient(colors: [.white.opacity(0.9), .clear]),
                        center: .center,
                        startRadius: 0,
                        endRadius: radius
                    )
                    .mask(Circle())

                    // Curseur
                    Circle()
                        .fill(Color.white)
                        .frame(width: 24, height: 24)
                        .shadow(color: .black.opacity(0.2), radius: isDragging ? 8 : 4)
                        .overlay(
                            Circle()
                                .stroke(Color(hue: hue, saturation: saturation, brightness: 1.0), lineWidth: 2)
                        )
                        .position(getCursorPosition(in: geometry))
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 0.3)) {
                                        isDragging = true
                                        updatePosition(from: value.location, in: geometry)
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(.spring()) {
                                        isDragging = false
                                    }
                                }
                        )
                }
                .contentShape(Circle())
            }
            .frame(width: 250, height: 250)

        }
    }

    private func getCursorPosition(in geometry: GeometryProxy) -> CGPoint {
        let radius = min(geometry.size.width, geometry.size.height) / 2
        let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)

        let angle = CGFloat(hue * 2 * .pi)
        let distance = CGFloat(saturation) * radius

        let x = center.x + cos(angle) * distance
        let y = center.y + sin(angle) * distance

        return CGPoint(x: x, y: y)
    }

    private func updatePosition(from location: CGPoint, in geometry: GeometryProxy) {
        let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
        let radius = min(geometry.size.width, geometry.size.height) / 2

        // Calculer le vecteur depuis le centre
        let vector = CGVector(dx: location.x - center.x, dy: location.y - center.y)

        // Calculer la distance (saturation)
        let distance = min(hypot(vector.dx, vector.dy), radius)
        saturation = Double(distance / radius)

        // Calculer l'angle (teinte)
        var angle = atan2(vector.dy, vector.dx)
        if angle < 0 { angle += 2 * .pi }
        hue = Double(angle / (2 * .pi))

        // Mettre à jour la couleur sélectionnée
        selectedColor = Color(hue: hue, saturation: saturation, brightness: 1.0)
    }
}

// Composant pour la barre d'aperçu de couleur
struct ColorPreviewBar: View {
    let hue: Double
    let saturation: Double
    @Binding var selectedColor: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // Rectangle de couleur
            RoundedRectangle(cornerRadius: 20)
                .fill(selectedColor)
                .frame(height: 80)

            // Valeurs RVB
            let colorComponents = selectedColor.cgColor?.components ?? [0, 0, 0, 1]
            let red = Int(colorComponents[0] * 255)
            let green = Int(colorComponents[1] * 255)
            let blue = Int(colorComponents[2] * 255)
        }
    }
}

// Extension pour extraire les composantes RVB
extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        UIColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        return (r, g, b, a)
    }
}

// Preview
#Preview {
    struct ColorWheelPreview: View {
        @State private var hue: Double = 0.5
        @State private var saturation: Double = 0.8
        @State private var selectedColor: Color = .blue

        var body: some View {
            ColorWheelView(hue: $hue, saturation: $saturation, selectedColor: $selectedColor)
                .padding()
        }
    }
    return ColorWheelPreview()
}
