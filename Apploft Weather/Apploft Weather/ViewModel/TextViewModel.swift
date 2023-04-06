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
        @Published var weatherdesc = AttributedString("Mock")
        @Published var cityT = AttributedString("Mock")
        @Published var temp = AttributedString("0°")
        @Published var humidity = AttributedString("Humidity: 00")
        @Published var windSpeed = AttributedString("Wind speed:00")
        @Published var windDirection = AttributedString("Wind direction: N")
        @Published var weathColor : WeatherColors = .clouds
        @Published var weatherCondition: Image = Image(weather: .cloudy)
        @Published var isLoaded = false
       
        
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
            
            weatherCondition = Image(weather: WeatherImage.convertWeatherImage(input: weathResp?.weather.first!.main ?? "Error"))
        }
        
        @MainActor func executeCurrentLocation(coord: (Double, Double)?) async {
            isLoaded = false
            
            guard let locCoord = coord else {
                print("Coords are nil")
                return
            }
            
            weathResp = await WeatherAPI.requestWeather(lat: locCoord.0, lon: locCoord.1)
            
            
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
            
            weatherCondition = Image(weather: WeatherImage.convertWeatherImage(input: weathResp?.weather.first!.main ?? "Error"))
            
            isLoaded = true

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
