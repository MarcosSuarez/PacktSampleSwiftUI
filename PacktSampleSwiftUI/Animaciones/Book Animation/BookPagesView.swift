//
//  BookPagesView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 26/11/22.
//

import SwiftUI

struct BookPagesView: View {
    
    @State var leftEndDegree: Angle = .zero
    @State var leftYOffset: CGFloat = 0
    @State var rightEndDegree: Angle = .zero
    @State var rightYOffset: CGFloat = -20
    
    @State var pagesDegree: Angle = .zero
    @Binding var animationStarted: Bool
    let pageWidth: CGFloat = 100
    let pageXOffset: CGFloat = -78
    let animationDuration: TimeInterval
    
    var body: some View {
        ZStack {
            Capsule()
                .foregroundColor(.white)
                .frame(width: pageWidth, height: 8)
                .offset(x: pageXOffset, y: leftYOffset)
                .rotationEffect(leftEndDegree)
                .animation(.easeOut(duration: animationDuration))
           
            Capsule()
                .foregroundColor(.white)
                .frame(width: pageWidth, height: 8)
                .offset(x: pageXOffset, y: rightYOffset)
                .rotationEffect(rightEndDegree)
                .animation(.easeOut(duration: animationDuration))
            
            ForEach(0..<13) { num in
                Capsule()
                    .foregroundColor(.white)
                    .frame(width: pageWidth, height: 8)
                    .offset(x: pageXOffset)
                    .rotationEffect(pagesDegree)
                    .animation(.easeOut(duration: animationDuration).delay((animationDuration * 0.21) * Double(num)))
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { animationTimer in
                if animationStarted {
                    animatePages()
                    Timer.scheduledTimer(withTimeInterval: animationDuration * 10, repeats: true) { _ in
                        animatePages()
                    }
                    animationTimer.invalidate()
                }
            }
        }
    }
    
    func animatePages() {
        rightEndDegree = .degrees(180)
        pagesDegree = .degrees(180)
        rightYOffset = 0
        
        // left page flipping over to the right
        Timer.scheduledTimer(withTimeInterval: animationDuration * 2.7, repeats: false) { _ in
            leftYOffset = 20
            leftEndDegree = .degrees(180)
        }
        // flip left page back to the left
        Timer.scheduledTimer(withTimeInterval: animationDuration * 5, repeats: false) { _ in
            leftYOffset = 0
            leftEndDegree = .zero
        }
        // middle pages turning to the left
        Timer.scheduledTimer(withTimeInterval: animationDuration * 5.25, repeats: false) { _ in
            pagesDegree = .degrees(0)
        }
        // flip rigth page to the left
        Timer.scheduledTimer(withTimeInterval: animationDuration * 7, repeats: false) { _ in
            rightEndDegree = .degrees(0)
            rightYOffset = -20
        }
    }
}

struct BookPagesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            BookPagesView(animationStarted: .constant(true),
                          animationDuration: 0.5)
        }
    }
}
