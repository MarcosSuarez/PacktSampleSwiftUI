//
//  FrameAndDoorsView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 30/10/22.
//

import SwiftUI

struct FrameAndDoorsView: View {
    @Binding var doorsOpenned: Bool
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                HStack {
                    Image("leftDoor")
                        .resizable()
                        .frame(maxWidth: geo.size.width)
                        .offset(x: doorsOpenned ? -geo.size.width / 2 : 4)
                    
                    Image("rightDoor")
                        .resizable()
                        .frame(maxWidth: geo.size.width)
                        .offset(x: doorsOpenned ? geo.size.width / 2 : -4)
                }
                Image("doorFrame")
                    .resizable()
                    .frame(maxWidth: geo.size.width, maxHeight: geo.size.height)
            }
            .animation(.easeInOut.speed(0.09).delay(0.3))
        }
    }
}

struct FrameAndoorView_Previews: PreviewProvider {
    static var previews: some View {
        FrameAndDoorsView(doorsOpenned: .constant(false))
    }
}
