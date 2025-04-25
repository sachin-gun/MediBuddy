import SwiftUI

struct LoginView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State var universityEmail: String = ""
    @State var password: String = ""
    @State var isShowingGuestModeNavigation: Bool = false
    @State var selectedBranch = ""
    @State var branches: [String] = []
    @State var showError: Bool = false
    @State var errorMessage: String = ""

    var body: some View {
        ZStack {
            CommonBackgroundView()
            VStack(spacing: 16) {
                Image("logo")
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
                    hint: "Password", password: $password)

                HStack {
                    Spacer()
                    HyperLinkTextView(text: "Forgot password?")
                        .onTapGesture {
                            globalDto.paths
                                .append(
                                    Route.forgotPasswordVerifyEmail.rawValue
                                )
                        }
                }

                Button {
                    Task {
                        await LoginViewModel.shared
                            .login(
                                username: universityEmail, password: password)

                        if globalDto.isLoggedIn {
                            globalDto.paths
                                .append(
                                    Route.home.rawValue
                                )
                        } else {
                            errorMessage = "Incorrect number or password."
                            showError = true
                        }
                    }

                } label: {
                    CommonButtonView(
                        buttonText: "Sign In",
                        backgroundColor: Color("brandColor"),
                        foregroundColor: Color.white
                    )
                }

//                Button {
//                    isShowingGuestModeNavigation.toggle()
//                } label: {
//                    CommonButtonView(
//                        buttonText: "Guest Mode",
//                        backgroundColor: Color("inputBackground"),
//                        foregroundColor: Color("brandColor")
//                    )
//                }

            }
            .padding(.horizontal, UIScreen.main.bounds.width * 0.05)

//            VStack {
//                Spacer()
//                HStack {
//                    NormalTextView(text: "Not a member?")
//                    HyperLinkTextView(text: "Register now")
//                        .onTapGesture {
//                            globalDto.paths
//                                .append(
//                                    Route.registration.rawValue
//                                )
//                        }
//                }
//            }
        }
        .onAppear {
            branches = LoginViewModel.shared.getBranches()
        }
        .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isShowingGuestModeNavigation) {
            VStack {
                VStack {
                    HStack {
                        SecondaryHeadingTextView(
                            text: "What is your primary branch?")
                        Spacer()
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                    List {

                        Section {
                            CommonDropDownListView(
                                options: $branches,
                                titleText: "Primary Branch",
                                selection: $selectedBranch
                            )
                            .onChange(of: selectedBranch) {
                                isShowingGuestModeNavigation = false
                                globalDto.paths
                                    .append(
                                        Route.home.rawValue
                                    )
                            }
                        }

                    }
                    .contentMargins(.vertical, 0)
                }
                Spacer()
            }
            .presentationDetents([.fraction(0.2)])
            .presentationDragIndicator(Visibility.visible)
            .ignoresSafeArea()
            .frame(maxWidth: .infinity)
            .padding(.top, 32)
            .background(Color("commonBackground"))
        }
        .alert(
            "Error!",
            isPresented: $showError
        ) {
            Button("Cancel", role: .cancel) {}
        } message: {
            NormalTextView(
                text: errorMessage, foregroundColor: Color.red)
        }
    }

}

#Preview {
    LoginView().environmentObject(GlobalDto.shared)
}
