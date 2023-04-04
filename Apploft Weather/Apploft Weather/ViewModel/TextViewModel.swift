//
//  ContentViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension TextView {
    class ViewModel: ObservableObject {
        
        private var weathResp: WeatherResponse?
        private var geoResp: GeoResponse?
        
        @Published var dayText = AttributedString(getDay().uppercased(), attributes: .init()
            .font(.system(size: 30))
        )
        @Published var weatherdesc = AttributedString("")
        @Published var cityT = AttributedString("")
        @Published var temp = AttributedString("")
        @Published var humidity = AttributedString("")
        @Published var windSpeed = AttributedString("")
        @Published var windDirection = AttributedString("")
        @Published var weathColor : WeatherColors = .clouds
       
        
        @MainActor func executeSearch(city: String) async {
            geoResp = await WeatherAPI.requestCoordinates(city: city)
            
            guard geoResp != nil else {
                return
            }
            
            weathResp = await WeatherAPI.requestWeather(lat: geoResp?.first!.lat ?? 0, lon: geoResp?.first!.lon ?? 0)
            
            
            weatherdesc = AttributedString(weathResp?.weather.first!.description.uppercased() ?? "Error", attributes: .init()
                .font(.system(size:20))
            )
            
            cityT = AttributedString(weathResp?.name.uppercased() ?? "Error", attributes: .init()
                .font(.system(size: 30, weight: .light))
            )
            
            temp = AttributedString("\(Int(weathResp?.main.temp ?? 0))°", attributes: .init()
                .font(.system(size: 100))
            )
            
            humidity = AttributedString("Humidity: \(weathResp?.main.humidity ?? 0)", attributes: .init()
                .font(.system(size: 16))
            )
            
            windSpeed = AttributedString("Wind speed: \(String(format: "%.2f", weathResp?.wind.speed ?? 0))", attributes: .init()
                .font(.system(size: 16))
            )
            
            windDirection = AttributedString("Wind direction: \(WindDirection.getDirection(deg: weathResp?.wind.deg ?? 0))", attributes: .init()
                .font(.system(size: 16))
            )
            
            weathColor = WeatherColors.convertWeatherColor(input: weathResp?.weather.first!.main ?? "Error")
        }
        
        static func getDay() -> String {
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en")
            dateFormatter.dateFormat = "EEEE"
            let dayOfTheWeekString = dateFormatter.string(from: date)
            return dayOfTheWeekString
        }
        
        
    }
}
