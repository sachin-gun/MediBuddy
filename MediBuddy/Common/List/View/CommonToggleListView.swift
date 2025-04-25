import SwiftUI

struct CommonToggleListView: View {
    @Binding var user: UserProfileModel
    @State var isAvailable: Bool = false
    var body: some View {
        HStack {
            NormalTextView(
                text: "Availability", foregroundColor: .black)
            Spacer()
            Toggle("", isOn: $isAvailable)
                .labelsHidden()
                .onChange(of: isAvailable) {
                    user.isAvailable = isAvailable
                }
        }
    }
}

#Preview {
    //    CommonToggleListView()
}
