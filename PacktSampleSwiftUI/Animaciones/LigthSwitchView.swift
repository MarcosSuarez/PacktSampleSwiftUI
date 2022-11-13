//
//  LigthSwitchView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 13/11/22.
//

import SwiftUI

struct LigthSwitchView: View {
    
    // MARK: - Variables
    private let appWidth = UIScreen.main.bounds.width
    private let appHeight = UIScreen.main.bounds.height
    private let animationDuration: TimeInterval = 0.35
    @State private var xScale: CGFloat = 2
    @State private var yScale: CGFloat = 0.4
    @State private var yOffset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var isOff: Bool = true
    
    
    var body: some View {
        ZStack {
            Color.black
            // MARK: - Circle view (our ligth)
            Circle().fill(Color.yellow)
                .scaleEffect(CGSize(width: xScale, height: yScale))
                .offset(y: yOffset)
            
            // MARK: - Arrow and Label at top
            VStack {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(isOff ? .white : .black)
                        .font(.system(size: 24, weight: .semibold, design: .monospaced))
                    Spacer()
                    Text("Study Room")
                        .foregroundColor(isOff ? .white : .black)
                        .font(.system(size: 32, weight: .bold, design: .monospaced))
                        .offset(x: -12)
                    Spacer()
                }
                .padding([.top, .bottom], 24)
                Spacer()
            }
            .offset(y: 32)
            .padding([.leading, .trailing], 24)
            
            // MARK: - Grey capsule for the end of te rope
            Capsule(style: .continuous)
                .foregroundColor(.gray)
                .frame(width: 52, height: appHeight * 0.25 + 6)
                .opacity(0.275)
                .offset(x: appWidth/2 - 48, y: 16)
            
            // MARK: - Rope and Ball
            ZStack {
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: 3, height:  isOff ? appHeight * 0.41 : appHeight * 0.625)
                Circle()
                    .fill(Color.white)
                    .frame(width: 42)
                    .offset(y: isOff ? appHeight * 0.225 : appHeight * 0.25 + 42)
                    .onTapGesture {
                        toggleAllLights()
                    }
            }
            .offset(x: appWidth/2 - 48, y: -appHeight/2)
            .frame(height: 0, alignment: .top)
        }
        .animation(.spring(dampingFraction: 0.65).speed(1.25))
        .edgesIgnoringSafeArea(.all)
    }
    
    func toggleAllLights() {
        if isOff {
            withAnimation(.easeIn(duration: animationDuration)) {
                xScale = 4
                yScale = 4
                yOffset = 0
            }
        } else {
            withAnimation(.easeIn(duration: animationDuration * 0.75)) {
                xScale = 2
                yScale = 0.4
                yOffset = UIScreen.main.bounds.height * 0.8
            }
        }
        isOff.toggle()
    }
}

struct LigthSwitchView_Previews: PreviewProvider {
    static var previews: some View {
        LigthSwitchView()
    }
}
