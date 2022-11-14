//
//  AppleMusicExampleApp.swift
//  AppleMusicExample
//
//  Created by Brandon Gouws on 2022/10/08.
//

import SwiftUI
import Swinject

@main
struct AppleMusicExampleApp: App {
    
    var dependencyManager = DependencyManager.shared.registerDependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class DependencyManager {
    
    let container = Container()
    static let shared = DependencyManager()
     
    private init() {
        registerDependencies()
    }
    
    public func registerDependencies() {
        container.register(WebServiceType.self) { _ in WebService() }
    }
}
