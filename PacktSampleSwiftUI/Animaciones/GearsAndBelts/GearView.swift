//
//  GearView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 5/11/22.
//

import SwiftUI

struct GearView: View {
    @State private var rotateGear = false
    var gearImage: String = ""
    var gearWidth: CGFloat = 0.0
    var gearDegrees: Double = 0.0
    var offsetGearX: CGFloat = 0.0
    var offsetGearY: CGFloat = 0.0
    var rotateDegrees: Double = 0.0
    /// time of full rotation
    var duration: Double = 0.0
    var xAxis: CGFloat = 0.0
    var yAxis: CGFloat = 0.0
    var zAxis: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            Image(gearImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: gearWidth)
                .rotationEffect(.degrees(rotateGear ? gearDegrees : 0))
                .animation(.linear(duration: duration).repeatForever(autoreverses: false), value: rotateGear)
                .rotation3DEffect(.degrees(rotateDegrees), axis: (x: xAxis, y: yAxis, z: zAxis))
                .offset(x: offsetGearX, y: offsetGearY)
        }
        .onAppear() {
            rotateGear.toggle()
        }
        .shadow(color: .black, radius: 1)
    }
}

struct GearView_Previews: PreviewProvider {
    static var previews: some View {
        GearView(gearImage: "doubleGear",
                 gearWidth: 100,
                 gearDegrees: 360,
                 offsetGearX: 0,
                 offsetGearY: 0,
                 rotateDegrees: 45,
                 duration: 5,
                 xAxis: 1,
                 yAxis: 1,
                 zAxis: 0)
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
