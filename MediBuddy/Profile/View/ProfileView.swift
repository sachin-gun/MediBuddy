import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var globalDto: GlobalDto
    @State var selectedBranch = ""
    @State var branches = [
        "Berkely", "Miami", "San Francisco", "New York",
    ]
    @State private var user: UserProfileModel = ProfileViewModel.shared
        .getUserProfile()

    var body: some View {
        ZStack {
            CommonBackgroundView()
            ScrollView {
                VStack(spacing: 16) {
                    HStack {
                        TitleTextView(text: user.shortName)
                        Spacer()
                        HyperLinkTextView(text: "Edit")
                            .onTapGesture {
                                globalDto.paths
                                    .append(
                                        Route.profileEdit.rawValue
                                    )
                            }
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)

                    List {
                        Section {
                            CommonStaticListView(
                                icon: "star.fill", titleText: "Points Earned",
                                valueText: "\(user.points)")
                        }
                        Section {
                            CommonDropDownListView(
                                options: $branches,
                                titleText: "Primary Branch",
                                selection: $selectedBranch
                            )
                        }

                        if globalDto.role.rawValue
                            == UserType.facultMember.rawValue
                        {
                            Section {
                                CommonToggleListView(user: $user)
                            }
                        }

                        Section {
                            CommonStaticListView(
                                icon: "", titleText: "First Name",
                                valueText: user.firstName)
                            CommonStaticListView(
                                icon: "", titleText: "Last Name",
                                valueText: user.lastName)
                            CommonStaticListView(
                                icon: "", titleText: "Email",
                                valueText: user.email)
                            CommonStaticListView(
                                icon: "", titleText: "Joined At",
                                valueText: user.joinedAt)
                        }

                    }
                    .contentMargins(.vertical, 0)
                    .frame(height: UIScreen.main.bounds.height * 0.5)

                    VStack(spacing: 16) {
                        Button {
                            globalDto.paths
                                .append(
                                    Route.profilePasswordReset.rawValue
                                )
                        } label: {
                            CommonButtonView(
                                buttonText: "Reset Password",
                                backgroundColor: Color("inputBackground"),
                                foregroundColor: Color("brandColor")
                            )
                        }

                        Button {
                            globalDto.paths.removeAll()
                            globalDto.isLoggedIn = false
                            globalDto.accessToken = ""
                            globalDto.refreshToken = ""
                            globalDto.role = .guest
                            globalDto.commingFrom = ""
                            globalDto.paths
                                .append(
                                    Route.login.rawValue
                                )
                        } label: {
                            CommonButtonView(
                                buttonText: "Sign Out",
                                backgroundColor: Color("inputBackground"),
                                foregroundColor: Color("brandColor")
                            )
                        }
                    }
                    .padding(.horizontal, UIScreen.main.bounds.width * 0.05)
                    Spacer()

                }
                .padding(.top, 32)
            }
        }
    }

}

#Preview {
    ProfileView().environmentObject(GlobalDto.shared)
}
