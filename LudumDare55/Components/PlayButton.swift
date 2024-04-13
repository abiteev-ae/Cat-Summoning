//
//  PlayButton.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import SwiftUI

struct PlayButton: View {
    @Binding var showImmersiveSpace: Bool

    var body: some View {
        VStack {
            Text(showImmersiveSpace ? "Stop" : "Play")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(width: 340, height: 110)
                .background(showImmersiveSpace ? Color.red : Color.green)
                .cornerRadius(20)
        }
        .onTapGesture {
            showImmersiveSpace.toggle()
        }
        .hoverEffect()
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.top, 50)
    }
}
