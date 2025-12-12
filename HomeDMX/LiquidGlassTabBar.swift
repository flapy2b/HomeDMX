import SwiftUI

struct LiquidGlassTabBar: View {
    @Binding var selected: Int

    var body: some View {
        HStack {
            tabButton(index: 0, title: "Couleurs", icon: "paintpalette.fill")
            Spacer()
            tabButton(index: 1, title: "Animations", icon: "film.fill")
            Spacer()
            tabButton(index: 2, title: "Picker", icon: "pencil.and.outline")
        }
        .padding(.horizontal, 30)
        .padding(.vertical, 14)
        .background(
            LiquidGlassBackground()
                .clipShape(RoundedRectangle(cornerRadius: 26, style: .continuous))
                .shadow(color: .black.opacity(0.12), radius: 20, y: 8)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 20)
    }

    // MARK: - Tab Button
    func tabButton(index: Int, title: String, icon: String) -> some View {
        let isSelected = selected == index

        return VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(isSelected ? .blue : .gray.opacity(0.5))

            Text(title)
                .font(.footnote)
                .foregroundStyle(isSelected ? .blue : .gray.opacity(0.6))
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .onTapGesture { withAnimation(.spring(response: 0.3)) { selected = index } }
    }
}

struct LiquidGlassBackground: View {
    var body: some View {
        ZStack {
            // Blur dynamique iOS 24
            Rectangle()
                .fill(.ultraThinMaterial)

            // Highlight glossy
            RoundedRectangle(cornerRadius: 26)
                .strokeBorder(Color.white.opacity(0.25), lineWidth: 1)
                .blur(radius: 1)
                .blendMode(.overlay)

            // Subtile brillance liquide
            RoundedRectangle(cornerRadius: 26)
                .fill(Color.white.opacity(0.12))
                .blur(radius: 20)
                .offset(y: -12)
                .blendMode(.screen)
        }
        .compositingGroup()
    }
}
