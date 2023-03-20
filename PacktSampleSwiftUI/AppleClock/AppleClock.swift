//
//  AppleClock.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 20/3/23.
//

import SwiftUI

// Reference: Paul Hudson
// https://youtu.be/dxxCPdcMcFw
// Código incompleto.

@available(iOS 15, *)
struct AppleClock: View {
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { ctx, size in
                let angles = getAngles(for: timeline.date)
                let rect = CGRect(origin: .zero, size: size)
                let radius = min(size.width, size.height)
                
                let border = radius / 25
                let hLength = radius / 2.5
                let mLength = radius / 1.5
                
                ctx.stroke(Circle()
                    .inset(by: border / 2)
                    .path(in: rect), with: .color(.primary), lineWidth: border)
                ctx.translateBy(x: rect.midX, y: rect.midY)
                drawHand(in: ctx, radius: radius, length: mLength, angle: angles.minute)
                drawHand(in: ctx, radius: radius, length: hLength, angle: angles.hour)
                
            }
        }
    }
    
    private func getAngles(for date: Date) -> (hour: Angle, minute: Angle, second: Angle) {
        let parts = Calendar.current.dateComponents([.hour, .minute, .second, .nanosecond], from: .now)
        let hours = Double(parts.hour ?? 0)
        let minutes = Double(parts.minute ?? 0)
        let seconds = Double(parts.second ?? 0)
        let nanoseconds = Double(parts.nanosecond ?? 0)
        
        let angleHours = Angle.degrees(30 * hours + 180)
        let angleMinute = Angle.degrees(6 * minutes + 180)
        let angleSeconds = Angle.degrees(6 * seconds + 180)
        
        return (angleHours, angleMinute, angleSeconds)
    }
    
    private func drawHand(in context: GraphicsContext,
                          radius: Double, length: Double, angle: Angle) {
        let width = radius / 30
        let stalk = Rectangle().rotation(angle, anchor: .top)
            .path(in: CGRect(x: -width / 2, y: 0, width: width, height: length))
        context.fill(stalk, with: .color(.primary))
    }
}

@available(iOS 15, *)
struct AppleClock_Previews: PreviewProvider {
    static var previews: some View {
        AppleClock()
    }
}
