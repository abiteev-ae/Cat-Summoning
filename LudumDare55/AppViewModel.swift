//
//  AppViewModel.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import Foundation

enum CatType: String, CaseIterable, Identifiable {
    case defaultCat = "default"

    var id: String { self.rawValue }
}

class AppViewModel: ObservableObject {
    @Published var catType: CatType = .defaultCat
}
