//
//  AppDelegate.swift
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    var dependencies: Dependencies!
    var builder: CoreBuilder!

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        var config: BuildConfiguration

        #if MOCK
        config = .mock(isSignedIn: true)
        #elseif DEV
        config = .dev
        #else
        config = .prod
        #endif

        config.configure()
        dependencies = Dependencies(config: config)
        builder = CoreBuilder(interactor: CoreInteractor(container: dependencies.container))
        return true
    }
}

enum BuildConfiguration {
    case mock(isSignedIn: Bool), dev, prod

    func configure() {
        switch self {
        case .mock:
            break
        case .dev:
            // TODO: Configure dev services (e.g., Firebase dev plist)
            break
        case .prod:
            // TODO: Configure prod services (e.g., Firebase prod plist)
            break
        }
    }
}
