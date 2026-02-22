//
//  __AppName__App.swift
//  Created by __Username__ on __Date__
//

import SwiftUI

@main
struct AppEntryPoint {
    static func main() {
        __AppName__App.main()
    }
}

struct __AppName__App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            delegate.builder.appView()
        }
    }
}
