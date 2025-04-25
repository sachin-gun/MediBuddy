import SwiftUI

struct CommonSquareImageView: View {
    var url: String
    let imageSize = UIScreen.main.bounds.width / 2.3
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .aspectRatio(1, contentMode: .fill)
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 15)
                    )
                    .clipped()
            } else {
                ProgressView()
                    .frame(width: imageSize, height: imageSize)
            }
        }
    }
}

#Preview {
    CommonSquareImageView(
        url:
            "https://images.unsplash.com/photo-1588075592672-2c05a193357f?q=80&w=2944&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D"
    )
}
