//
//  CircleEmitter.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 26/11/22.
//

import SwiftUI

struct CircleEmitter: View {
    @Binding var isAnimating: Bool
    
    var body: some View {
        CirclesView()
            .fill(Color.white.opacity(0.75))
            .scaleEffect(isAnimating ? 2 : 0)
            .animation(isAnimating ? Animation.spring() : Animation.easeInOut(duration: 0))
    }
}

struct CircleEmitter_Previews: PreviewProvider {
    static var previews: some View {
        CircleEmitter(isAnimating: .constant(false))
    }
}
