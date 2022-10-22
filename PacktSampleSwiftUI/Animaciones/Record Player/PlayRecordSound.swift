//
//  PlayRecordSound.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 22/10/22.
//

import AVFoundation

class PlayRecordSound {
    
    var audioPlayer: AVAudioPlayer?
    
    func playSound(sound: String, type: String) {
        if let path = Bundle.main.path(forResource: sound, ofType: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
                print("Se consiguió la pista de audio")
            } catch {
                print("No pude encontrar la URL para la canción: \(sound).\(type)")
            }
        } else {
            print("No pude encontrar el Bundle para la canción: \(sound).\(type)")
        }
    }
    
    func stop() {
        audioPlayer?.stop()
    }
}
