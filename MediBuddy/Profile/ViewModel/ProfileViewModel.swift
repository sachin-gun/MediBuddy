import SwiftUI

class ProfileViewModel {
    static let shared = ProfileViewModel()

    private init() {}

    func getUserProfile() -> UserProfileModel {
        //network call
        return UserProfileModel(
            role: UserType.facultMember,
            shortName: "Himasha, W.",
            firstName: "Himasha",
            lastName: "Weerasooriya",
            email: "himasha@gmail.com",
            joinedAt: "27th of February 2025",
            primaryBranch: "Berkely",
            points: 14250,
            isAvailable: false
        )
    }
}
