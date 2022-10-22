//
//  RecordView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 22/10/22.
//

import SwiftUI

struct RecordView: View {
    @Binding var degrees: Double
    @Binding var shouldAnimate: Bool
    
    var body: some View {
        Image("record")
            .resizable()
            .frame(width: 275, height: 275)
            .shadow(color: .gray, radius: 1)
            .rotationEffect(Angle.degrees(degrees))
            .animation(Animation
                .linear(duration: shouldAnimate ? 60 : 0).delay(1.5)
            )
    }
}

struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(
            degrees: .constant(2), shouldAnimate: .constant(true)
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
