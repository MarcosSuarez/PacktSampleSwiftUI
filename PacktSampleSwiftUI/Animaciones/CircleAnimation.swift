//
//  CircleAnimation.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 22/10/22.
//

import SwiftUI

struct CircleAnimation: View {
    @State private var scaleInOut = false
    @State private var rotateInOut = false
    @State private var moveInOut = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .edgesIgnoringSafeArea(.all)
            ZStack {
                // MARK: - Circles Set 1
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white],
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white],
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                
                // MARK: - Circles Set 2
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white],
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white],
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                    .rotationEffect(.degrees(60))
                
                // MARK: - Circles Set 3
                ZStack {
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white],
                                             startPoint: .top,
                                             endPoint: .bottom))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? -60 : 0)
                    
                    Circle()
                        .fill(LinearGradient(colors: [.green, .white],
                                             startPoint: .bottom,
                                             endPoint: .top))
                        .frame(width: 120, height: 120)
                        .offset(y: moveInOut ? 60 : 0)
                }.opacity(0.5)
                    .rotationEffect(.degrees(120))
                
            } // Second ZStack
            .rotationEffect(.degrees(rotateInOut ? 90 : 0))
            .scaleEffect(scaleInOut ? 1 : 1/4)
            .animation(Animation.easeInOut.repeatForever(autoreverses: true).speed(1/8))
            .onAppear {
                moveInOut.toggle()
                scaleInOut.toggle()
                rotateInOut.toggle()
            }
        } // First ZStack
    }
}

struct CircleAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CircleAnimation()
    }
}
