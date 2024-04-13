//
//  AboutButton.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import SwiftUI

struct AboutButton: View {
    var onTap: () -> Void

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Spacer()
                Image(systemName: "info.circle")
                    .foregroundColor(.white)
                    .font(.title)
                Spacer()
                Text("About")
                    .font(.title2)
                    .foregroundColor(.white)
                Spacer()
                Spacer()
            }
            .frame(width: 180, height: 60)
            .background(Color.white.opacity(0.2))
        }
        .onTapGesture {
            onTap()
        }
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.top, 50)
    }
}
