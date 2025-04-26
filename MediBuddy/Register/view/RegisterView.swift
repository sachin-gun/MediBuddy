import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var universityEmail: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var navigateToLogin = false

    var body: some View {
        NavigationStack {
            ZStack {
                CommonBackgroundView()

                ScrollView {
                    VStack(spacing: 16) {
                        Image("register")
                        HeadingTextView(text: "Sign Up")
                            .padding(.top, 16)

                        NormalTextView(
                            text: "Create your account using the provided university email.",
                            multilineTextAlignment: .center
                        )

                        CommonTextInputView(hint: "First name", text: $firstName)
                        CommonTextInputView(hint: "Last name", text: $lastName)

                        CommonTextInputView(
                            hint: "Phone number", text: $universityEmail
                        )
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)

                        CommonPasswordInputView(hint: "Password", password: $password)
                        CommonPasswordInputView(hint: "Confirm Password", password: $confirmPassword)

                        NormalTextView(
                            text: "Your password must be at least 8 characters, include a number, an uppercase letter, a lowercase letter, and a special character.",
                            multilineTextAlignment: .center
                        )

                        Button(action: {
                            // You could validate input before navigating
                            navigateToLogin = true
                        }) {
                            CommonButtonView(
                                buttonText: "Sign Up",
                                backgroundColor: Color("brandColor"),
                                foregroundColor: Color.white
                            )
                        }
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                }

                // Navigation link to LoginView
                NavigationLink(
                    destination: LoginView(),
                    isActive: $navigateToLogin
                ) {
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    RegisterView().environmentObject(GlobalDto.shared)
}
