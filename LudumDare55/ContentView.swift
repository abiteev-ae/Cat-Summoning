//
//  ContentView.swift
//  LudumDare55
//
//  Created by Alihan Abiteev on 13.04.2024.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        HomeView(viewModel: viewModel)
    }
}
