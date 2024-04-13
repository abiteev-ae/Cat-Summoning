//
//  AboutView.swift
//  LudumDare55
//
//  Created by Nikita Sabynin on 13.04.2024.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ScrollView {
            CenteredTitle("About")
                .padding(.bottom, 20)

            Spacer()

            VStack(alignment: .leading) {
                Text("""
                👋 Hello yopta!

                I hope you like cats. If you not, close the app immediately!
                """)
                .accentColor(.cyan)
                .padding(.bottom, 10)

                Text("Contributions")
                    .font(.title3)
                Text("""
                Alihan The Great
                Ilya The GOAT
                Nikita The G
                Alice The Cat
                """)
                .accentColor(.cyan)
                .padding(.bottom, 10)

                Text("Credits")
                    .font(.title3)
                Text("""
                - Cats
                - Some of the dogs
                - LUDUM DARE 55 orgs are good people
                """)
                .accentColor(.cyan)
                .padding(.bottom, 10)


                Text("Privacy Policy")
                    .font(.title3)
                Text("""
                - N/A
                    - App does not collect any information. Have Fun!
                """)
                .padding(.bottom, 10)

                Text("✌️✌️✌️")
                    .font(.title)
                    .padding(.bottom, 10)
            }
            .padding(.bottom, 10)


                .frame(height: 600)


        }
    }
}

#Preview {
    AboutView()
}
