import SwiftUI

struct Header: View {
    var body: some View {
            VStack(alignment: .leading) {
                Text("HomeDMX")
                    .font(.title.bold())
                    .foregroundColor(.primary)

                HStack {
                    ForEach(0..<5) { index in
                        Circle()
                            .frame(width: 22, height: 15)
                            .foregroundColor([
                                .red, .green, .blue, .yellow, .purple
                            ][index])
                    }
                }
                .padding(.top, 4)
            }
            .padding(.top, 20)
            .padding(.horizontal)
        }
}

#Preview{
    Header()
}
