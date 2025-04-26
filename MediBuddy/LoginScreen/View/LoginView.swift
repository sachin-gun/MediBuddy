import SwiftUI

struct LoginView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State private var universityEmail: String = ""
    @State private var password: String = ""
    @State private var isShowingGuestModeNavigation: Bool = false
    @State private var selectedBranch = ""
    @State private var branches: [String] = []

    var body: some View {
        ZStack {
            CommonBackgroundView()

            VStack(spacing: 16) {
//                Image("logo")
                HeadingTextView(text: "Sign In")
                    .padding(.top, 16)
                NormalTextView(
                    text: "Access to your account",
                    multilineTextAlignment: .center
                )

                CommonTextInputView(
                    hint: "Phone number",
                    text: $universityEmail
                )

                CommonPasswordInputView(
                    hint: "Password", password: $password
                )

                HStack {
                    Spacer()
                    HyperLinkTextView(text: "Forgot password?")
                        .onTapGesture {
                            globalDto.paths.append(Route.forgotPasswordVerifyEmail.rawValue)
                        }
                }

                Button {
                    globalDto.paths.append(Route.PermanentLoginView.rawValue)
                } label: {
                    CommonButtonView(
                        buttonText: "Sign In",
                        backgroundColor: Color("brandColor"),
                        foregroundColor: Color.white
                    )
                }
            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
        }
        .onAppear {
            branches = LoginViewModel.shared.getBranches()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    LoginView().environmentObject(GlobalDto.shared)
}
