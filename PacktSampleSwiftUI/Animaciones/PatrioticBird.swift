//
//  PatrioticBird.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 23/10/22.
//

import SwiftUI

struct PatrioticBird: View {
    @State private var leftWing = false
    @State private var rightWing = false
    @State private var birdBody = false
    @State private var animateShadow = false
    
    var body: some View {
        ZStack{
            Color(red: 0.0, green: 0.0, blue: 0.0)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                // MARK: - left wing
                Image("birdLeftWing")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .shadow(color: .red, radius: 1)
                    .rotationEffect(.degrees(leftWing ? -100 : 0), anchor: .bottomTrailing)
                    .offset(x: -55, y: leftWing ? -190 : 0)
                    .animation(.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true))
                // MARK: - rigth wing
                Image("birdRightWing")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .shadow(color: .blue, radius: 1)
                    .rotationEffect(.degrees(rightWing ? 100 : 0), anchor: .bottomLeading)
                    .offset(x: 55, y: rightWing ? -190 : 0)
                    .animation(.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true))
                // MARK: - Body
                Image("birdBody")
                    .resizable()
                    .frame(width: 100, height: 125)
                    .offset(y: -30)
                    .shadow(color: .white, radius: 1)
                    .offset(y: birdBody ? -50 : 75)
                    .animation(.easeInOut(duration: 1)
                        .repeatForever(autoreverses: true))
            }
            .shadow(color: .white,
                    radius: animateShadow ? 1 : 4,
                    x: 0,
                    y: animateShadow ? 10: 1)
            .animation(.easeInOut(duration: 1)
                .repeatForever(autoreverses: true))
        }
        .onAppear() {
            leftWing.toggle()
            rightWing.toggle()
            birdBody.toggle()
            animateShadow.toggle()
        }
    }
}

struct PatrioticBird_Previews: PreviewProvider {
    static var previews: some View {
        PatrioticBird()
    }
}
