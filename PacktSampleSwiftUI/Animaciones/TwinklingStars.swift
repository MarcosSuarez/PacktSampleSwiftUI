//
//  TwinklingStars.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 1/11/22.
//

import SwiftUI

struct TwinklingStars: View {
    @State private var animateYellow = false
    @State private var animateBlue = false
    @State private var animateRed = false
    @State private var animatePurple = false
    @State private var animateGreen = false
    @State private var starsThickness: CGFloat = 0.0
    var startPoints: Int = 0
    
    var body: some View {
        ZStack {
            // MARK: - Background
            Image("stars")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                // Yeloww
                CreateStar(starPoints: 30,
                           startThickness: $starsThickness,
                           animateStar: $animateYellow,
                           fillColor: .yellow,
                           starSizeStar: 0.2,
                           starSizeEnd: 0.4,
                           shadowColor: .yellow)
                .offset(y: 100)
                .onAppear() {
                    withAnimation(Animation.easeOut(duration: 2.3).repeatForever(autoreverses: true)) {
                        animateYellow.toggle()
                        starsThickness = 0.35
                    }
                }
                // Blue
                CreateStar(starPoints: 4,
                           startThickness: $starsThickness,
                           animateStar: $animateBlue,
                           fillColor: .blue,
                           starSizeStar: 0.1,
                           starSizeEnd: 0.3,
                           shadowColor: .blue)
                .offset(x: 70,y: -60)
                .onAppear() {
                    withAnimation(Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)) {
                        animateBlue.toggle()
                        starsThickness = 0.35
                    }
                }
                // Red
                CreateStar(starPoints: 4,
                           startThickness: $starsThickness,
                           animateStar: $animateRed,
                           fillColor: .red,
                           starSizeStar: 0.2,
                           starSizeEnd: 0.4,
                           shadowColor: .red)
                .offset(x: -70, y: -150)
                .onAppear() {
                    withAnimation(Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)) {
                        animateRed.toggle()
                        starsThickness = 0.35
                    }
                }
                // Purple
                CreateStar(starPoints: 6,
                           startThickness: $starsThickness,
                           animateStar: $animatePurple,
                           fillColor: .purple,
                           starSizeStar: 0.2,
                           starSizeEnd: 0.4,
                           shadowColor: .purple)
                .offset(x: 80, y: -120)
                .onAppear() {
                    withAnimation(Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)) {
                        animatePurple.toggle()
                        starsThickness = 0.35
                    }
                }
                // Green
                CreateStar(starPoints: 8,
                           startThickness: $starsThickness,
                           animateStar: $animateGreen,
                           fillColor: .green,
                           starSizeStar: 0.2,
                           starSizeEnd: 0.4,
                           shadowColor: .green)
                .offset(x: -80, y: -170)
                .onAppear() {
                    withAnimation(Animation.easeOut(duration: 3.3).repeatForever(autoreverses: true)) {
                        animateGreen.toggle()
                        starsThickness = 0.35
                    }
                }
            }
        }
    }
}

struct Star: Shape {
    let starPoints: Int
    var starThickness: CGFloat
    var animatableData: CGFloat {
        get { starThickness }
        set { starThickness = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        // make sure the stars has at least 3 points
        guard starPoints >= 3 else { return Path() }
        // create an x and y point to start the drawing from
        let drawPoint = CGPoint(x: rect.width / 1.2, y: rect.width / 0.5)
        // make the angle of the star straight up (changes this value to change th stars angle)
        var starAngle = -CGFloat.pi / 2
        // adjust the stars angle based on how many points are chosen
        let adjustedStarAngle = .pi * 2 / CGFloat(starPoints * 2)
        // adjust the inner x and y points of the start based on the stars thickness
        let pointX = drawPoint.x * starThickness
        let pointY = drawPoint.y * starThickness
        // create a path instance to start the drawing
        var path = Path()
        // start the path off at the initial position we set drawpoint to be... we'll use a little math here to move the path along on the x and y points.
        path.move(to: CGPoint(x: drawPoint.x * cos(starAngle), y: drawPoint.y * sin(starAngle)))
        // keep track of the lowest point so we can center it
        var bottomEdge: CGFloat = 0
        
        // loop over all points and figure out the location of this point with some math
        for corner in 0..<starPoints * 2 {
            let sinAngle = sin(starAngle)
            let cosAngle = cos(starAngle)
            let bottom: CGFloat
            // check to see if we are multiple of two, if so, then we are drawing the outer edge of star
            if corner.isMultiple(of: 2) {  // 8 = meteoro
                bottom = drawPoint.y * sinAngle // store this position in bottom
                // add a line to there
                path.addLine(to: CGPoint(x: drawPoint.x * cosAngle, y: bottom))
            } else {
                // in the else, we're not a multiple of 2, so we are drawing an inner point
                bottom = pointY * sinAngle // store this y position in bottom
                // add a line to there
                path.addLine(to: CGPoint(x: pointX * cosAngle, y: bottom))
            }
            // check the bottom var, if this new bottom point is our lowest, store it in bottomEdge for later
            if bottom > bottomEdge {
                bottomEdge = bottom
            }
            // move on to the next corner
            starAngle += adjustedStarAngle
        }
        // calculate how much unused space we have at the bottom of our drawing rectangle
        let bottomSpace = (rect.height / 2 - bottomEdge) / 2
        // create and add a transform that oves the path down by that amount, centering the shape vertically
        let transform = CGAffineTransform(translationX: drawPoint.x, y: drawPoint.y + bottomSpace)
        
        return path.applying(transform)
    }
}


struct CreateStar: View {
    var starPoints: Int
    @Binding var startThickness: CGFloat
    @Binding var animateStar: Bool
    
    var fillColor: Color
    var starSizeStar: CGFloat
    var starSizeEnd: CGFloat
    var shadowColor: Color
    
    var body: some View {
        VStack {
            Star(starPoints: starPoints, starThickness: startThickness)
                .fill(fillColor)
                .frame(width: 80, height: 80)
                .scaleEffect(animateStar ? starSizeStar : starSizeEnd)
                .shadow(color: shadowColor, radius: 20, x: 3, y: 3)
        }
    }
}

struct TwinklingStars_Previews: PreviewProvider {
    static var previews: some View {
        TwinklingStars()
    }
}
