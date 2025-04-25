import SwiftUI

class LoginViewModel {
    static let shared = LoginViewModel()

    private init() {}

    func getBranches() -> [String] {
        let branches = [
            "Berkely", "Miami", "San Francisco", "New York",
        ]
        return branches
    }

    func login(username: String, password: String) async {

        //need to call API

        for user in GlobalDto.shared.users {
            if user.username == username && user.password == password {
                await MainActor.run {
                    GlobalDto.shared.isLoggedIn = true
                    GlobalDto.shared.role = user.role
                }
                break
            } else {
                await MainActor.run {
                    GlobalDto.shared.isLoggedIn = false
                }
            }
        }
    }
}
