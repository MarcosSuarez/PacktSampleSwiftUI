//
//  DataWeaderModel.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 5/11/22.
//

import Foundation

struct DataWeatherModel {
    let day: String
    let data: CGFloat
    
    /// weekly temperature data
    static let temperature: [DataWeatherModel] = [
        .init(day: "Su", data: 0.9),
        .init(day: "M", data: 0.7),
        .init(day: "T", data: 0.9),
        .init(day: "W", data: 0.8),
        .init(day: "TH", data: 0.75),
        .init(day: "F", data: 0.65),
        .init(day: "Sa", data: 0.85)
    ]
    /// weekly Precipitation data
    static let precipitation: [DataWeatherModel] = [
        .init(day: "Su", data: 0.4),
        .init(day: "M", data: 0.6),
        .init(day: "T", data: 0.2),
        .init(day: "W", data: 0.3),
        .init(day: "TH", data: 0.4),
        .init(day: "F", data: 0.9),
        .init(day: "Sa", data: 0.5)
    ]
    /// weekly Wind data
    static let wind: [DataWeatherModel] = [
        .init(day: "Su", data: 0.8),
        .init(day: "M", data: 0.4),
        .init(day: "T", data: 0.3),
        .init(day: "W", data: 0.3),
        .init(day: "TH", data: 0.5),
        .init(day: "F", data: 0.3),
        .init(day: "Sa", data: 0.2)
    ]
}

