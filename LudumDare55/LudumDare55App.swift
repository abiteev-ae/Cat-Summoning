//
//  LudumDare55App.swift
//  LudumDare55
//
//  Created by Alihan Abiteev on 13.04.2024.
//

import SwiftUI

@main
struct LudumDare55App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView()
        }
    }
}
