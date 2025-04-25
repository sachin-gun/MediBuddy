import SwiftUI

class GlobalDto: ObservableObject {
    static let shared = GlobalDto()

    let users: [User] = [
        .init(
            username: "sanuga1@gmail.com",
            password: "11111111",
            role: UserType
                .scholar),
        .init(
            username: "sanuga2@gmail.com",
            password: "11111111",
            role: UserType
                .facultMember),
        .init(
            username: "sachin1@gmail.com",
            password: "11111111",
            role: UserType
                .scholar),
        .init(
            username: "sachin2@gmail.com",
            password: "11111111",
            role: UserType
                .facultMember),
        .init(
            username: "duvindu1@gmail.com",
            password: "11111111",
            role: UserType
                .scholar),
        .init(
            username: "duvindu2@gmail.com",
            password: "11111111",
            role: UserType
                .facultMember),
    ]
    @Published var isLoggedIn: Bool = false
    @Published var accessToken: String = ""
    @Published var refreshToken: String = ""
    @Published var role: UserType = .guest

    @Published var paths: [String] = []
    @Published var commingFrom: String = ""

    private init() {}
}
