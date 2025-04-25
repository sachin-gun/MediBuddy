//
//  MediBuddyApp.swift
//  MediBuddy
//
//  Created by Sachin Gunawardena on 2025-04-23.
//

import FirebaseCore
//import Firebase
import SwiftUI

//import FirebaseAuth
//import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication
            .LaunchOptionsKey: Any]? = nil
    ) -> Bool {
        FirebaseApp.configure()

        return true
    }
}



@main
struct MediBuddyApp: App {
    @StateObject private var globalDto = GlobalDto.shared

    //    init() {
    //        FirebaseApp.configure()
    //        NotificationManager.shared.requestPermission()
    //    }

    //    init() {
    //            FirebaseApp.configure()
    //        }
    //
    init() {
        NotificationManager.shared.requestPermission()
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $globalDto.paths) {
                PermanentLoginView()
                    .navigationDestination(for: String.self) { route in
                        switch route {
                        case Route.home.rawValue:
                            HomeView()
                        //                        case Route.forgotPasswordVerifyEmail.rawValue:
                        ////                            ForgotPasswordView()
                        case Route.registration.rawValue:
                            RegisterView()
                        default:
                            EmptyView()
                        }
                    }
            }
            .environmentObject(globalDto)
        }
    }
}
