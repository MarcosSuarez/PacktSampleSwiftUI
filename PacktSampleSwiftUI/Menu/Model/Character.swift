//
//  Character.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 5/12/22.
//

import SwiftUI

// Ref: https://www.youtube.com/watch?v=jvzJmnoFGoE&t=43s

// MARK: - Character model for holding data about each alphabet
struct Character: Identifiable {
    var id: String = UUID().uuidString
    var value: String
    var index: Int = 0
    var rect: CGRect = .zero
    var pushOffset: CGFloat = 0
    var isCurrent: Bool = false
    var color: Color = .clear
}
