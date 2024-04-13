//
//  CatSelector.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import SwiftUI

struct CatTypeSelection: View {
    @ObservedObject var viewModel: AppViewModel

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text("Choose your cat")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                // TODO: make it cat
                Picker("Choose your cat", selection: $viewModel.catType) {
                    ForEach(CatType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.palette)
                .padding(.top, 12)
            }
            .padding(.horizontal, geometry.size.width * 0.20)
        }
    }
}
