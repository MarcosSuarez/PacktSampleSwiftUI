//
//  WeatherPickerView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 5/11/22.
//

import SwiftUI

struct WeatherPickerView: View {
    @Binding var pickerSelection: Int
    
    var body: some View {
        Picker(selection: $pickerSelection, label: Text("")) {
            Text("Temperature 🌡").tag(0)
            Text("Precipitation 🌧").tag(1)
            Text("Wind 🌬").tag(2)
        }
        .pickerStyle(.segmented)
        .background(RoundedRectangle(cornerRadius: 8)
            .stroke(Color.black, lineWidth: 2)
            .shadow(color: .black, radius: 8))
        .cornerRadius(8)
        .padding(.horizontal, 10)
        .padding(.bottom, 15)
    }
}

struct WeatherPickerView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherPickerView(pickerSelection: .constant(3))
            .previewLayout(.fixed(width: 350, height: 100))
    }
}
