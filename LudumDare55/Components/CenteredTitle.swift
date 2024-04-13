//
//  CenteredTitle.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import SwiftUI

struct CenteredTitle: View {
    let title: String

    init(_ title: String) {
           self.title = title
    }

    var body: some View {
        Text(title)
            .font(.largeTitle)
            .frame(maxWidth: .infinity, alignment: .center)
    }
}

#Preview {
    CenteredTitle("Some Title")
}
