//
//  BookLoaderView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 26/11/22.
//

import SwiftUI

struct BookLoaderView: View {
    
    @State var bookState: BookLoaderState = .closeRight
    
    @State var leftCoverOffset: CGSize = CGSize(width: -84, height: 0)
    @State var leftRotatioDegrees: Angle = .zero
    
    @State var middleBookOffset: CGSize = CGSize(width: -28, height: -28)
    @State var middleRotatioDegrees: Angle = .degrees(-90)
    
    @State var rightCoverOffset: CGSize = CGSize(width: 84, height: 55.75)
    @State var rightRotatioDegrees: Angle = .degrees(-180)
    
    @State var currentIndex = 0
    @State var animationStarted: Bool = false
    
    let bookCoverWidth: CGFloat = 120
    let animationDuration: TimeInterval = 0.4
    
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            // left book cover
            Capsule()
                .foregroundColor(.white)
                .frame(width: bookCoverWidth, height: 8)
                .offset(leftCoverOffset)
                .rotationEffect(leftRotatioDegrees)
            // Spine
            BookHoldView()
                .stroke(style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .miter))
                .foregroundColor(.white)
                .rotationEffect(middleRotatioDegrees)
                .offset(middleBookOffset)
            // right book cover
            Capsule()
                .foregroundColor(.white)
                .frame(width: bookCoverWidth, height: 8)
                .offset(rightCoverOffset)
                .rotationEffect(rightRotatioDegrees)
            // pages in the middle
            BookPagesView(animationStarted: $animationStarted, animationDuration: animationDuration)
                .offset(y: -20)
        }
        .onTapGesture {
            animationStarted.toggle()
            animateBookCovers()
            
            Timer.scheduledTimer(withTimeInterval: animationDuration *  3.4, repeats: false) { _ in
                animateBookClosed()
                // Close the other direction
                Timer.scheduledTimer(withTimeInterval: animationDuration * 5, repeats: true) { _ in
                    animateBookClosed()
                }
            }
        }
    }
    
    // MARK: - Funtions
    func animateBookCovers() {
        // spine
        withAnimation(.easeOut(duration: animationDuration)) {
            middleRotatioDegrees = bookState.animationBegin.3
            middleBookOffset = bookState.animationBegin.2
        }
        // left and rigth book cover offset
        withAnimation(.easeOut(duration: animationDuration)) {
            leftCoverOffset = bookState.animationBegin.0
            rightCoverOffset = bookState.animationBegin.4
        }
        // rotation degrees for the left and right book covers
        withAnimation(.easeOut(duration: animationDuration * 0.9).delay(animationDuration * 0.05)) {
            leftRotatioDegrees = bookState.animationBegin.1
            rightRotatioDegrees = bookState.animationBegin.5
        }
    }
    
    func animateBookClosed() {
        withAnimation(.linear(duration: animationDuration)) {
            middleRotatioDegrees = bookState.animationEnd.3
            leftCoverOffset = bookState.animationEnd.0
            rightCoverOffset = bookState.animationEnd.4
        }
        
        withAnimation(.easeOut(duration: animationDuration)) {
            leftRotatioDegrees = bookState.animationEnd.1
            rightRotatioDegrees = bookState.animationEnd.5
            middleBookOffset = bookState.animationEnd.2
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration * 1.6, repeats: false) { _ in
            bookState = getNextCase()
            animateBookCovers()
        }
    }
    
    func getNextCase() -> BookLoaderState {
        let allCases = BookLoaderState.allCases
        
        if currentIndex == allCases.count - 1 {
            currentIndex = -1
        }
        currentIndex += 1
        let index = currentIndex
        return allCases[index]
    }
    
}

enum BookLoaderState: CaseIterable {
    case closeRight
    case closeLeft
    
    var animationBegin: (CGSize, Angle, CGSize, Angle, CGSize, Angle) {
        switch self {
        case .closeRight:
            return (CGSize(width: -84, height: 0), Angle.degrees(0),
                    CGSize(width: 0, height: 0), Angle.degrees(0),
                    CGSize(width: 84, height: 0), Angle.degrees(0))
        case .closeLeft:
            return (CGSize(width: -84, height: 0), Angle.degrees(0),
                    CGSize(width: 0, height: 0), Angle.degrees(0),
                    CGSize(width: 84, height: 0), Angle.degrees(0))
        }
    }
    
    var animationEnd: (CGSize, Angle, CGSize, Angle, CGSize, Angle) {
        switch self {
        case .closeRight:
            return (CGSize(width: -84, height: 55.75), Angle.degrees(180),
                    CGSize(width: 28, height: -28), Angle.degrees(90),
                    CGSize(width: 84, height: 0), Angle.degrees(0))
        case .closeLeft:
            return (CGSize(width: -84, height: 0), Angle.degrees(0),
                    CGSize(width: -28, height: -28), Angle.degrees(-90),
                    CGSize(width: 84, height: 55.75), Angle.degrees(-180))
        }
    }
}

struct BookLoaderView_Previews: PreviewProvider {
    static var previews: some View {
        BookLoaderView()
    }
}
