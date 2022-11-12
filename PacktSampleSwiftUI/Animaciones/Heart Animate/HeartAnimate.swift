//
//  HeartAnimate.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 12/11/22.
//

import SwiftUI

struct HeartAnimate: View {
    @State private var strokeReset: Bool = true
    @State private var startStroke: CGFloat = 0.0
    @State private var endStroke: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            GeometryReader { geo in
                // MARK: - Stationary heart shape
                ZStack {
                    HeartShape()
                        .stroke(style: StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.white)
                        .opacity(0.4)
                    
                    // MARK: - Animated heard stroke
                    HeartShape()
                        .trim().trim(from: startStroke, to: endStroke)
                        .stroke(style: StrokeStyle(lineWidth: 6))
                        .foregroundColor(.white)
                    
                    // MARK: - Image heart
                    Image("heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 175, alignment: .center)
                        .position(x: geo.size.width/4.1, y: geo.size.height/8.5)
                }
                .position(x: geo.size.width/1.3, y: geo.size.height/1.2)
                .onAppear() {
                    Timer.scheduledTimer(withTimeInterval: 0.15, repeats: true) { timer in
                        if endStroke >= 1 {
                            if strokeReset {
                                Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                                    endStroke = 0
                                    startStroke = 0
                                    strokeReset.toggle()
                                }
                                strokeReset = false
                            }
                        }
                        withAnimation(.easeOut) {
                            endStroke += 0.1
                            startStroke = endStroke - 0.3
                        }
                    }
                }
            }
        }
    }
}

struct HeartAnimate_Previews: PreviewProvider {
    static var previews: some View {
        HeartAnimate()
    }
}
