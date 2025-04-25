import SwiftUI

struct ProfilePasswordResetView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State var user: UserProfileModel?
    @State var currentPassword: String = ""
    @State var newPassword: String = ""
    @State var confirmPassword: String = ""

    var body: some View {
        ZStack {
            CommonBackgroundView()

            VStack {
                HStack {
                    TitleTextView(text: "Password Reset")
                    Spacer()
                    if currentPassword.isEmpty == false
                        && newPassword.isEmpty == false
                        && confirmPassword.isEmpty == false
                        && newPassword == confirmPassword
                    {
                        HyperLinkTextView(text: "Reset")
                            .onTapGesture {
                                globalDto.paths.removeLast()
                            }
                    } else {
                        HyperLinkTextView(isEnabled: false, text: "Reset")
                    }
                }
                .padding(.horizontal, UIScreen.main.bounds.width * 0.05)

                List {
                    Section {
                        CommonListPasswordInputView(
                            password: $currentPassword,
                            titleText: "Current Password"
                        )
                        CommonListPasswordInputView(
                            password: $newPassword,
                            titleText: "New Password"
                        )
                        CommonListPasswordInputView(
                            password: $confirmPassword,
                            titleText: "Confirm Password"
                        )
                    }
                    Section(
                        footer: FootnoteTextView(
                            text:
                                "Your password must be at least 8 characters, include a number, an uppercase letter, a lowercase letter and a special character."
                        )
                    ) {}
                }
                .contentMargins(.vertical, 0)

            }
            .padding(.top, 32)

        }
        .onAppear {
            user = ProfileViewModel.shared
                .getUserProfile()
        }
    }

}

#Preview {
    ProfilePasswordResetView()
}
