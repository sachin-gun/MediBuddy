import SwiftUI

struct ContactImageView: View {
    var image: String = ""
    var body: some View {
        Image(image)
            .resizable()
            .frame(
                width:
                    UIScreen.main.bounds.width
                    * 0.08,
                height:
                    UIScreen.main.bounds.width
                    * 0.08)
    }
}

#Preview {
    ContactImageView()
}
