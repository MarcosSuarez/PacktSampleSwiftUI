//
//  HueRotationExample.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 23/10/22.
//

import SwiftUI

struct HueRotationExample: View {
    @State private var shiftColors = false
    @State private var image = "dog"
    let backgroundColor = Color(.black)
    
    var body: some View {
        VStack {
            ZStack {
                backgroundColor
                    .scaleEffect(1.4)
                Image(image)
                    .resizable()
                    .padding(20)
                    .frame(width: 350, height: 350)
                    .hueRotation(Angle(degrees: shiftColors ? 360*2  : 0))
                    .animation(.easeInOut(duration: 2)
                        .delay(0.4)
                        .repeatForever(autoreverses: true))
                    .onAppear() {
                        shiftColors.toggle()
                    }
            }
            ImagePicker(selectedImage: $image)
                .frame(width: 300, height: 200)
        }.background(Color.black)
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ImagePicker: View {
    @Binding var selectedImage: String
    let imagesName = ["ornament", "landscape", "dog", "dice", "cat"]
    
    var body: some View {
        Picker("", selection: $selectedImage) {
            ForEach(imagesName, id: \.self) { value in
                Text(value).foregroundColor(.white)
            }
        }.pickerStyle(.wheel)
            .frame(width: 300, height: 150)
            .background(Color.red.colorMultiply(.blue))
            .cornerRadius(20)
            .shadow(color: .white, radius: 5)
    }
}

struct HueRotationExample_Previews: PreviewProvider {
    static var previews: some View {
        HueRotationExample()
    }
}
