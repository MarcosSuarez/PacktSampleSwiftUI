//
//  ImageExample2.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 22/10/22.
//

import SwiftUI

struct ImageExample2: View {
    @State private var img: UIImage?
    let staticImage = UIImage(named: "caballitoMar1")
    
    var body: some View {
        Image(uiImage: img ?? staticImage!)
            .resizable()
            .onAppear(perform: imageDownloader)
            .frame(width: 400, height: 400, alignment: .center)
            .onTapGesture {
                print("La imagen a sido presionada")
            }
    }

    // MARK: - Descarga
    private let urlString = "https://picsum.photos/400/400?i=30"
    
    func imageDownloader() {
        guard let imgURL = URL(string: urlString)
        else {
            print("No pude conseguir la imagen")
            return
        }
        URLSession.shared.dataTask(with: imgURL) { data, response, error in
            if let imageData = data,
               let imageToDisplay = UIImage(data: imageData) {
                img = imageToDisplay
            } else {
                print("error: \(String(describing: error))")
            }
        }.resume()
    }
}

struct ImageExample2_Previews: PreviewProvider {
    static var previews: some View {
        ImageExample2()
    }
}
