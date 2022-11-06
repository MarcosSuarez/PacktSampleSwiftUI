//
//  BeltView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 6/11/22.
//

import SwiftUI

struct BeltView: View {
    @State var animatedBelt: Bool = false
    var beltWidth: CGFloat = 0.0
    var beltHeight: CGFloat = 0.0
    var offsetBeltX: CGFloat = 0.0
    var offsetBeltY: CGFloat = 0.0
    var dashPhaseValue: CGFloat = 40.0
    var rotateDegrees: Double = 0.0
    var xAxis: CGFloat = 0.0
    var yAxis: CGFloat = 0.0
    var zAxis: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Capsule()
                .trim().trim(from: 0, to: 1)
                .stroke(.black, style: StrokeStyle(lineWidth: 7,
                                                   lineJoin: .round,
                                                   dash: [5, 1.4],
                                                   dashPhase: animatedBelt ? dashPhaseValue : 0))
                .frame(width: beltWidth, height: beltHeight)
                .animation(.linear(duration: 3).repeatForever(autoreverses: false).speed(3), value: animatedBelt)
                .onAppear() {
                    animatedBelt.toggle()
                }
        }
        .shadow(color: .black, radius: 10, x: 1, y: 0)
        .rotationEffect(.degrees(rotateDegrees), anchor: .center)
        .offset(x: offsetBeltX, y: offsetBeltY)
    }
}

struct BeltView_Previews: PreviewProvider {
    static var previews: some View {
        BeltView(animatedBelt: true,
                 beltWidth: 250,
                 beltHeight: 50,
                 offsetBeltX: 0,
                 offsetBeltY: 0,
                 dashPhaseValue: 40,
                 rotateDegrees: 60,
                 xAxis: 0,
                 yAxis: 0,
                 zAxis: 0)
        .previewLayout(.fixed(width: 200, height: 400))
    }
}
