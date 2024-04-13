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

                Spacer()
                Spacer()

                Text("Contributions")
                    .font(.title3)
                Text("""
                Alihan The Great
                Ilya The GOAT
                Nikita The G
                Alice The Cat
                """)
                .accentColor(.cyan)

                Spacer()
                Spacer()

                Text("Credits")
                    .font(.title3)
                Text("""
                - Cats
                - Some of the dogs
                - LUDUM DARE 55 orgs are good people
                """)
                .accentColor(.cyan)

                Spacer()
                Spacer()

                Text("Privacy Policy")
                    .font(.title3)
                Text("""
                - N/A
                    - App does not collect any information. Have Fun!
                """)
            }
            .padding(.bottom, 26)

            Text("FAQ")
                .font(.title)

//            Faq()
                .frame(height: 600)

            Text("✌️")
                .font(.title)
                .padding(.bottom, 10)

        }
        .padding(.horizontal, 40)
    }
}

#Preview {
    AboutView()
}
