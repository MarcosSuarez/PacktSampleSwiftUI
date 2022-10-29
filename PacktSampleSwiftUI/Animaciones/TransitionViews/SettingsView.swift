//
//  Fly.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 29/10/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var selection: Int = 1
    @State private var setDate = Date()
    @State private var timeZoneOverrride = true
    @State private var volume: Double = 25.0
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    // Date Picker
                    Section(header: Text("Date and Time")) {
                        DatePicker(selection: $setDate) {
                            Image(systemName: "calendar.circle")
                        }
                        .foregroundColor(.black)
                    }
                    .listRowBackground(Color.orange)
                    
                    // Time zone toggle
                    Section(header: Text("Time Zone Override")) {
                        Toggle(isOn: $timeZoneOverrride) {
                            HStack {
                                Image(systemName: "timer")
                                Text("Override")
                            }.foregroundColor(.black)
                        }
                    }
                    .listRowBackground(Color.orange)
                    
                    // Alarm volume
                    Section(header: Text("Alarm Volume")) {
                        Text("Volumen \(String(format: "%.0f", volume)) Decibels").foregroundColor(.black)
                        Slider(value: $volume, in: 0...100) { _ in
                            // code to run when the slider is moved
                        }
                    }
                    .listRowBackground(Color.orange)
                    
                    // repeat alarm picker
                    Section(header: Text("Repeat Alarm")) {
                        Picker(selection: $selection,
                               label: Text("Repeat Alarm:"))
                        {
                            Text("No repeat").tag(1)
                            Text("Repeat Once").tag(2)
                            Text("Repeat Twice").tag(3)
                        }.foregroundColor(.black)
                    }
                    .listRowBackground(Color.orange)
                    
                    // save button
                    Button {
                        withAnimation(.easeInOut(duration: 1)) {
                            self.show = false
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Save")
                            Spacer()
                        }
                    }
                    .listRowBackground(Color.green)
                }
                .foregroundColor(.white)
                .listStyle(.insetGrouped)
            }
            .frame(width: 350, height: 625)
            .cornerRadius(20)
            
            Text("Settings")
                .offset(y: -250)
                .foregroundColor(.black)
                .font(.title)
        }
    }
}

struct Fly_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(show: .constant(false))
    }
}
