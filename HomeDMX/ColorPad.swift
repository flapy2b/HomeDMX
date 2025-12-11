import SwiftUI

struct ColorPad: View {
    let color: Color
    let isSelected: Bool
    @State private var isPressed = false

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(color)
                .frame(width: 140, height: 80)
                .scaleEffect(isPressed ? 0.95 : 1.0)
                .overlay(
                    RoundedRectangle(cornerRadius: isSelected ? 15 : 0)
                        .stroke(isSelected ? Color.blue : Color.clear,
                               lineWidth: isSelected ? 3 : 0)
                )

            if color == .white {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 0.5)
                    .frame(width: 60, height: 60)
            }
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isPressed || isSelected)
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in self.isPressed = true }
                .onEnded { _ in self.isPressed = false }
        )
    }
}
