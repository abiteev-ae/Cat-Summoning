//
//  LudumDare55App.swift
//  LudumDare55
//
//  Created by Alihan Abiteev on 13.04.2024.
//

import SwiftUI

@main
struct LudumDare55App: App {
    @StateObject private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .frame(minWidth: 640, minHeight: 500)
        }

        ImmersiveSpace(id: "ImmersiveSpace") {
            ImmersiveView(viewModel: viewModel)
        }
    }
}
