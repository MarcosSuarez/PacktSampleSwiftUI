//
//  ExpandView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 12/11/22.
//

import SwiftUI

struct ExpandView: View {
    @State var isAnimating: Bool = false
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            ZStack {
                ExpandingView(expand: $isAnimating,
                              direction: .bottom, symbolName: "note.text")
                ExpandingView(expand: $isAnimating,
                              direction: .left, symbolName: "doc")
                ExpandingView(expand: $isAnimating,
                              direction: .top, symbolName: "photo")
                ExpandingView(expand: $isAnimating,
                              direction: .rigth, symbolName: "mic.fill")
                // MARK: - Center Image
                Image(systemName: "plus")
                    .font(.system(size: 40,
                                  weight: isAnimating ? .regular : .semibold,
                                  design: .rounded))
                    .foregroundColor(isAnimating ? Color.white : Color.black)
                    .rotationEffect(isAnimating ? .degrees(45) : .degrees(0))
                    .scaleEffect(isAnimating ? 3 : 1)
                    .opacity(isAnimating ? 0.5 : 1)
                    .animation(.spring(response: 0.35,
                                       dampingFraction: 0.85,
                                       blendDuration: 1))
                    .onTapGesture {
                        isAnimating.toggle()
                    }
            }
        }
    }
}

struct ExpandView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandView()
    }
}
