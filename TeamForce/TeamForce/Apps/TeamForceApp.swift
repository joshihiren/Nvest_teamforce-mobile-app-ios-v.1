//
//  TeamForceApp.swift
//  TeamForce
//
//  Created by Hiren Joshi on 16/01/21.
//

import SwiftUI

@main
struct TeamForceApp: App {
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            computedView()
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
    }
    
    func computedView() -> some View {
        //        SplashView()
        HomeTabbar()
    }
    
}
