import SwiftUI

struct PinnedItemButtonView: View {
    var text: String
    var body: some View {
        Text(text)
            .font(.callout)
            .fontWeight(.medium)
            .foregroundColor(
                Color("commonTextColor")
            )
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                Color("inputBackground")
            )
            .cornerRadius(50)
    }
}

#Preview {
    PinnedItemButtonView(text: "fjsdal")
}
