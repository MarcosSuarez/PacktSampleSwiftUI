//
//  WeatherUIView.swift
//  PacktSampleSwiftUI
//
//  Created by Marcos Suárez on 5/11/22.
//

import SwiftUI

struct WeatherUIView: View {
    // array to hold the three weekly weather data options
    @State var dataArray = [DataWeatherModel.temperature,
                            DataWeatherModel.precipitation,
                            DataWeatherModel.wind]
    var capsuleWidth: CGFloat = 14
    @State private var pickerSelection = 0
    @State private var isOn = false
    @State private var animateTemp = false
    @State private var animatePrecip = false
    @State private var animateWind = false
    @State private var animateTempImage = false
    @State private var animatePrecipImage = false
    @State private var animateWindImage = false
    
    init() {
        // the foreground color each selected segment
        UISegmentedControl.appearance().selectedSegmentTintColor = .black
        // the color of the title for the selected segment
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor:UIColor.white], for: .selected)
        // the color of the title for the unselected segment
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
    }
    
    var body: some View {
        ZStack {
            Color(.sRGB, red: 255/255, green: 195/255, blue: 0/255)
                .edgesIgnoringSafeArea(.all)
            VStack {
                // MARK: - SunMoonToggle imported
                SunMoonToggleView(isOn: $isOn)
                // MARK: - Title
                Text("Weather")
                    .font(.system(size: 40))
                    .fontWeight(.medium)
                    .font(.title)
                    .shadow(color: .black, radius: 1)
                // MARK: - Picker Segment
                WeatherPickerView(pickerSelection: $pickerSelection)
                    .onReceive([pickerSelection].publisher) { value in
                        if value == 0 {
                            // set the text labels for each segment n the picker
                            animateTemp = true
                            animatePrecip = false
                            animateWind = false
                            // set the images for each segment on the picker
                            animateTempImage = true
                            animatePrecipImage = false
                            animateWindImage = false
                        } else if value == 1 {
                            // set the text labels for each segment n the picker
                            animateTemp = false
                            animatePrecip = true
                            animateWind = false
                            // set the images for each segment on the picker
                            animateTempImage = false
                            animatePrecipImage = true
                            animateWindImage = false
                        } else if value == 2  {
                            // set the text labels for each segment n the picker
                            animateTemp = false
                            animatePrecip = false
                            animateWind = true
                            // set the images for each segment on the picker
                            animateTempImage = false
                            animatePrecipImage = false
                            animateWindImage = true
                        }
                    }
                
                // MARK: - Weekly Graph
                ZStack {
                    HStack(spacing: 20) {
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][0], width: 350 / capsuleWidth)
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][1], width: 350 / capsuleWidth)
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][2], width: 350 / capsuleWidth)
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][3], width: 350 / capsuleWidth)
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][4], width: 350 / capsuleWidth)
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][5], width: 350 / capsuleWidth)
                        WeeklyGraph(dayHeightData: dataArray[pickerSelection][6], width: 350 / capsuleWidth)
                    }
                    .animation(.spring(response: 0.9, dampingFraction: 0.6))
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(lineWidth: 1)
                        .shadow(radius: 8, x: 3, y: 3)
                        .padding(.horizontal, 10)
                }
                GeometryReader { geo in
                    VStack {
                        if animateTemp {
                            Text("Temperature")
                                .fontWeight(.medium)
                                .font(.title)
                                .shadow(color: .black, radius: 1, y: 2)
                                .transition(.offset(x: 300))
                                .animation(.easeInOut(duration: 1.0))
                        }
                        if animatePrecip {
                            Text("Precipitation")
                                .fontWeight(.medium)
                                .font(.title)
                                .shadow(color: .black, radius: 1, y: 2)
                                .transition(.offset(x: -300))
                                .animation(.easeInOut(duration: 1.0))
                        }
                        if animateWind {
                            Text("Wind")
                                .fontWeight(.medium)
                                .font(.title)
                                .shadow(color: .black, radius: 1, y: 2)
                                .transition(.offset(x: 300))
                                .animation(.easeInOut(duration: 1.0))
                        }
                    }
                    .position(x: geo.size.width * 0.5, y: geo.size.height * 0.2)
                    
                    VStack {
                        if animateTempImage {
                            Image("tempImage")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width/2, height: geo.size.height/2)
                                .position(y: geo.size.height/2)
                                .transition(.offset(y: 300))
                                .animation(.easeOut(duration: 1.0))
                            
                        }
                        if animatePrecipImage {
                            Image("precip")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width/2, height: geo.size.height/2)
                                .position(y: geo.size.height/2)
                                .transition(.offset(x: 300))
                                .animation(.easeOut(duration: 1.0))
                        }
                        if animateWindImage {
                            Image("wind")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width/2, height: geo.size.height/2)
                                .position(y: geo.size.height/2)
                                .transition(.offset(x: -300))
                                .animation(.easeOut(duration: 1.0))
                        }
                    }
                    .position(x: geo.size.width, y: geo.size.height * 0.6)

                }
                
            }
        }
    }
}

struct WeatherUIView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherUIView()
    }
}
