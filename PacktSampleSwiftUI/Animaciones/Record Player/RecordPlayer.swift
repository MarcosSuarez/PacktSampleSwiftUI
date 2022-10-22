//
//  RecordPlayer.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 22/10/22.
//

import SwiftUI

struct RecordPlayer: View {
    @State private var rotateRecord = false
    @State private var rotateArm = false
    @State private var shouldAnimate = false
    @State private var degrees = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [.white, .black]),
                           center: .center,
                           startRadius: 20,
                           endRadius: 600)
            // MARK: - Record Player Box
            RecordPlayerBox().offset(y: -100)
            
            // MARK: - Record
            VStack {
                RecordView(degrees: $degrees,
                           shouldAnimate: $shouldAnimate)
                ArmView(rotateArm: $rotateArm)
                
                // MARK: - Button
                Button {
                    shouldAnimate.toggle()
                    if shouldAnimate {
                        degrees = 36000
                        rotateArm.toggle()
                        playMusic(single: .classic)
                    } else {
                        rotateArm.toggle()
                        degrees = 0
                        stopMusic()
                    }
                } label: {
                    HStack(spacing: 0) {
                        if !shouldAnimate {
                            Text("Play")
                            Image(systemName: "play.circle.fill")
                                .imageScale(.large)
                        } else {
                            Text("Stop")
                            Image(systemName: "stop.fill")
                                .imageScale(.large)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(Capsule().strokeBorder(Color.black, lineWidth: 1.25))
                }
            }

        }
        .edgesIgnoringSafeArea(.all)
    }
    
    
    let musicData = PlayRecordSound()
    
    private enum Singles {
        case classic
    }
    
    private func playMusic(single: Singles) {
        switch single {
        case .classic:
            musicData.playSound(sound: "recordMusic", type: "m4a")
        }
    }
    
    private func stopMusic() {
        musicData.stop()
    }
}

struct RecordPlayer_Previews: PreviewProvider {
    static var previews: some View {
        RecordPlayer()
    }
}
