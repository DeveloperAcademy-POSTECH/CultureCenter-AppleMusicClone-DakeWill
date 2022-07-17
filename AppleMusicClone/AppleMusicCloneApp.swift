//
//  AppleMusicCloneApp.swift
//  AppleMusicClone
//
//  Created by 박성수 on 2022/06/27.
//

import SwiftUI
import FirebaseCore

@main
struct AppleMusicCloneApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
                MainView()
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
