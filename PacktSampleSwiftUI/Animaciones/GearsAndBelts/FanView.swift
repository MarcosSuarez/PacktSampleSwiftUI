//
//  FanView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 6/11/22.
//

import SwiftUI

struct FanView: View {
    @State var rotateFan: Bool = false
    var degrees: Double = 360 * 4
    
    var body: some View {
        ZStack {
            Image("fan")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
                .rotationEffect(.degrees(rotateFan ? degrees : 0), anchor: .center)
                .animation(.linear(duration: 4).repeatForever(autoreverses: false), value: rotateFan)
                .onAppear() {
                    rotateFan.toggle()
                }
                .shadow(color: .black, radius: 15)
        }
    }
}

struct FanView_Previews: PreviewProvider {
    static var previews: some View {
        FanView()
    }
}
