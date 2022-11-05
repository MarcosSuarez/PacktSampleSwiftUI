//
//  WeeklyGraph.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 5/11/22.
//

import SwiftUI

struct WeeklyGraph: View {
    var dayHeightData: DataWeatherModel
    var width: CGFloat
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                Capsule()
                    .opacity(0.3)
                    .frame(width: width + 2, height: 200)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .stroke(.black, lineWidth: 2)
                        .shadow(color: .black, radius: 8))
                Capsule()
                    .frame(width: width, height: dayHeightData.data * 200)
                    .overlay(RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .opacity(0.9))
            }
            .padding(.bottom, 8)
            Text(dayHeightData.day)
                .font(.system(size: 14))
        }
    }
}

struct WeeklyGraph_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyGraph(dayHeightData: DataWeatherModel(day: "Today", data: 0.8),
                    width: 30)
    }
}
