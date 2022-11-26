//
//  WifiView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 13/11/22.
//

import SwiftUI

extension Color {
    static let wifiBackground: Color = Color(r: 5, g: 23, b: 46)
    static let wifiShadow: Color = Color(r: 13, g: 50, b: 125)
    static let wifiConnected: Color = Color(r: 170, g: 255, b: 197)
    
    init(r: Double, g: Double, b: Double) {
        self.init(red: r/255, green: g/255, blue: b/255)
    }
}

struct WifiView: View {
    
    // MARK: - Variables
    @State var isAnimating: Bool = false
    @State var isConnected: Bool = false
    
    @State var circleOffset: CGFloat = 20
    @State var smallArcOffset: CGFloat = 16
    @State var mediumArcOffset: CGFloat = 14.5
    @State var largeArcOffset: CGFloat = 14
    
    @State var arcColor: Color = Color.white
    @State var shadowColor: Color = .blue
    
    @State var wifiHeaderLabel: String = "Wi-Fi"
    
    static var animationMovingUpwards: Bool = true
    static var rotateArc: Bool = true
    
    var animationDuration: Double = 0.35
    
    var body: some View {
        ZStack {
            Color.wifiBackground.edgesIgnoringSafeArea(.all)
            
            // MARK: - Emitter animation
            CircleEmitter(isAnimating: $isConnected)
                .offset(y: 90)
                .frame(height: 300)
            
            // MARK: - Circles and arcs
            ZStack {
                // small circle
                Circle().fill(arcColor)
                    .scaleEffect(0.075)
                    .shadow(color: .blue, radius: 5)
                    .offset(y: circleOffset)
                    .animation(.easeOut(duration: animationDuration))
                
                // three arcs and large stroked circle
                ZStack {
                    ArcView(radius: 12, fillColor: $arcColor, shadowColor: $shadowColor)
                        .rotationEffect(getRotation(arcBoolean: Self.rotateArc))
                        .offset(y: smallArcOffset)
                        .animation(.easeOut(duration: animationDuration))
                    
                    ArcView(radius: 24, fillColor: $arcColor, shadowColor: $shadowColor)
                        .rotationEffect(getRotation(arcBoolean: Self.rotateArc))
                        .offset(y: mediumArcOffset)
                        .animation(.easeOut(duration: animationDuration).delay(animationDuration))
                    
                    ArcView(radius: 36, fillColor: $arcColor, shadowColor: $shadowColor)
                        .rotationEffect(getRotation(arcBoolean: Self.rotateArc))
                        .offset(y: mediumArcOffset)
                        .animation(.easeOut(duration: animationDuration).delay(animationDuration * 1.9))
                    
                    // Outside circle
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 2.5))
                        .foregroundColor(.white)
                        .opacity(0.5)
                    Circle()
                        .fill(Color.blue.opacity(0.1))
                    
                    // animating fill circle
                    Circle()
                        .fill(Color.blue.opacity(0.045))
                        .scaleEffect(isAnimating ? 5 : 0)
                        .animation(isAnimating ? .easeIn(duration: animationDuration * 2.5).repeatForever(autoreverses: false) : Animation.linear(duration: 0))
                }
                .onTapGesture {
                    isAnimating.toggle()
                    wifiHeaderLabel = "Searching"
                    smallArcOffset -= 7.5
                    circleOffset -= 15
                    mediumArcOffset = -5.5
                    largeArcOffset = -19
                    isConnected = false
                    arcColor = .white
                    shadowColor = .blue
                    
                    // MARK: - First Timer
                    Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: true) {  arcTimer in
                        if isAnimating {
                            circleOffset += Self.animationMovingUpwards ? -15 : 15
                            smallArcOffset += Self.rotateArc ? -15 : 15
                            if circleOffset == -25 {
                                Self.animationMovingUpwards = false
                            } else if circleOffset == 20 {
                                Self.animationMovingUpwards = true
                            }
                            if Self.rotateArc {
                                mediumArcOffset += -15
                            }
                        } else {
                            arcTimer.invalidate()
                        }
                    }
                    // MARK: - Timer 2
                    Timer.scheduledTimer(withTimeInterval: animationDuration * 2, repeats: true) { arcTimer in
                        if isAnimating {
                            mediumArcOffset += 15
                        } else {
                            arcTimer.invalidate()
                        }
                    }
                    // MARK: - Timer 3
                    Timer.scheduledTimer(withTimeInterval: animationDuration * 3, repeats: true) { arcTimer in
                        if isAnimating {
                            Self.rotateArc.toggle()
                            smallArcOffset = !Self.rotateArc ? -15 : 8.5
                            if Self.animationMovingUpwards {
                                largeArcOffset = -19
                                mediumArcOffset = -5.5
                            } else {
                                largeArcOffset = 14
                                mediumArcOffset = 0
                            }
                        } else {
                            arcTimer.invalidate()
                        }
                    }
                    // MARK: - Timer 4
                    Timer.scheduledTimer(withTimeInterval: animationDuration * 12, repeats: false) { _ in
                        restoreAnimation()
                        arcColor = .wifiConnected
                        shadowColor = .white.opacity(0.5)
                        wifiHeaderLabel = "Connected"
                        isConnected.toggle()
                        
                        // MARK: - Timer 5
                        Timer.scheduledTimer(withTimeInterval: animationDuration + 0.05, repeats: false) { _ in
                            isConnected.toggle()
                        }
                    }
                }
                Text(wifiHeaderLabel)
                    .font(.system(size: 28, weight: .semibold, design: .rounded))
                    .opacity(isAnimating ? 0 : 1)
                    .foregroundColor(.white)
                    .offset(y: 100)
                    .animation(isAnimating ? .spring().speed(0.65).repeatForever(autoreverses: false) : .linear(duration: 0).repeatCount(0))
            }
            .frame(height: 120)
        }
    }
    
    func getRotation(arcBoolean: Bool) -> Angle {
        if isAnimating && arcBoolean {
            return Angle.degrees(180)
        }
        return Angle.degrees(0)
    }
    
    func restoreAnimation() {
        isAnimating = false
        Self.animationMovingUpwards = true
        Self.rotateArc = true
        
        circleOffset = 20
        smallArcOffset = 16
        mediumArcOffset = 14.5
        largeArcOffset = 14
    }
}

struct WifiView_Previews: PreviewProvider {
    static var previews: some View {
        WifiView()
    }
}
