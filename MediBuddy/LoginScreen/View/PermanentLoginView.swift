//
//  PermanentLoginView.swift
//  medi buddy test
//
//  Created by Sachin Gunawardena on 2025-04-20.
//

import SwiftUI

struct PermanentLoginView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isShowingRegister: Bool = false
    @StateObject private var biometricAuth = BiometricAuth()


    var body: some View {
        ZStack {
            CommonBackgroundView()

            VStack(spacing: 24) {
                Spacer().frame(height: 40)
                
//                Image("health-login-illustration")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 180)

                VStack(spacing: 4) {
                    Text("Welcome Back,")
                        .font(.title3.bold())
                        .foregroundColor(.primary)

                    Text("Kamal")
                        .font(.title2.bold())
                        .foregroundColor(.teal)
                }

                Text("Use Biometrics to login to your account")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                Button {
                    biometricAuth.authenticate()
                } label: {
                    Image(systemName: "faceid")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .padding()
                }
                .onChange(of: biometricAuth.isAuthenticated) {
                    if biometricAuth.isAuthenticated {
                        globalDto.isLoggedIn = true
                        globalDto.paths.append(Route.home.rawValue)
                    }
                }
                if let error = biometricAuth.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }




                CommonPasswordInputView(
                    hint: "Or Use Password",
                    password: $password
                )

                HStack {
                    HyperLinkTextView(text: "Forgot password ?")
                        .onTapGesture {
                            globalDto.paths.append(Route.forgotPasswordVerifyEmail.rawValue)
                        }
                    Spacer()
                    HyperLinkTextView(text: "Log me out")
                        .onTapGesture {
                            globalDto.paths = []
                        }
                }

//                Button {
//                    Task {
//                        await LoginViewModel.shared.login(username: globalDto.user.email ?? "", password: password)
//                        if globalDto.isLoggedIn {
//                            globalDto.paths.append(Route.home.rawValue)
//                        } else {
//                            errorMessage = "Incorrect password."
//                            showError = true
//                        }
//                    }
//                } label: {
//                    CommonButtonView(
//                        buttonText: "Register new account",
//                        backgroundColor: .clear,
//                        foregroundColor: Color("brandColor")
//                    )
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color("brandColor"), lineWidth: 1)
//                    )
//                }

                Spacer()

                HStack(spacing: 40) {
                    VStack {
                        Image(systemName: "person.text.rectangle")
                            .font(.title)
                        Text("Doctors list")
                            .font(.caption)
                    }
                    .onTapGesture {
                        globalDto.paths.append(Route.facility.rawValue)
                    }

                    Divider().frame(height: 40)

                    VStack {
                        Image(systemName: "phone.circle")
                            .font(.title)
                        Text("Emergency contact")
                            .font(.caption)
                    }
                    .onTapGesture {
                        globalDto.paths.append(Route.facility.rawValue)
                    }
                }
            }
            .padding()
        }
        .alert("Error!", isPresented: $showError) {
            Button("OK", role: .cancel) {}
        } message: {
            NormalTextView(text: errorMessage, foregroundColor: .red)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    PermanentLoginView().environmentObject(GlobalDto.shared)
}
