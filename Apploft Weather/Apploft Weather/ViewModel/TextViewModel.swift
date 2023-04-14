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
        @Published var searchText = ""
       
        
        @MainActor func executeSearch(city: String?) async {
            isLoaded = false
            
            guard let safeCity = city else {
                isLoaded = true
                searchText = ""
                return
            }
            
            let urlCity = safeCity.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            guard let safeUrlCity = urlCity else  {
                isLoaded = true
                searchText = ""
                return
            }
            
            geoResp = await WeatherAPI.requestCoordinates(city: safeUrlCity)
            guard let safeGeoResp = geoResp else {
                isLoaded = true
                searchText = ""
                return
            }
            guard let nonEmptResp = safeGeoResp.first else {
                print("empty geo array")
                isLoaded = true
                searchText = ""
                return
            }
            
            weathResp = await WeatherAPI.requestWeather(lat: nonEmptResp.lat, lon: nonEmptResp.lon)
            guard let safeWeathResp = weathResp else {
                isLoaded = true
                searchText = ""
                return
            }
            
            weatherdesc = AttributedString(safeWeathResp.weather.first!.description.uppercased(), attributes: .init()
                .font(.system(size:20))
            )
            
            cityT = AttributedString(safeWeathResp.name.uppercased(), attributes: .init()
                .font(.system(size: 30, weight: .light))
            )
            
            temp = AttributedString("\(Int(safeWeathResp.main.temp))°", attributes: .init()
                .font(.system(size: 100))
            )
            
            humidity = AttributedString("Humidity: \(safeWeathResp.main.humidity)", attributes: .init()
                .font(.system(size: 16))
            )
            
            windSpeed = AttributedString("Wind speed: \(String(format: "%.2f", safeWeathResp.wind.speed))", attributes: .init()
                .font(.system(size: 16))
            )
            
            windDirection = AttributedString("Wind direction: \(WindDirection.getDirection(deg: safeWeathResp.wind.deg))", attributes: .init()
                .font(.system(size: 16))
            )
            
            weathColor = WeatherColors.convertWeatherColor(input: safeWeathResp.weather.first!.main)
            
            weatherCondition = Image(weather: WeatherImage.convertWeatherImage(input: safeWeathResp.weather.first!.main))
            
            isLoaded = true
            searchText = ""
        }
        
        @MainActor func executeCurrentLocation(coord: (Double, Double)?) async {
            isLoaded = false
            
            guard let safeCoord = coord else {
                isLoaded = true
                print("Coords are nil")
                return
            }
            
            weathResp = await WeatherAPI.requestWeather(lat: safeCoord.0, lon: safeCoord.1)
            guard let safeWeathResp = weathResp else {
                isLoaded = true
                return
            }
            
            weatherdesc = AttributedString(safeWeathResp.weather.first!.description.uppercased(), attributes: .init()
                .font(.system(size:20))
            )
            
            cityT = AttributedString(safeWeathResp.name.uppercased(), attributes: .init()
                .font(.system(size: 30, weight: .light))
            )
            
            temp = AttributedString("\(Int(safeWeathResp.main.temp))°", attributes: .init()
                .font(.system(size: 100))
            )
            
            humidity = AttributedString("Humidity: \(safeWeathResp.main.humidity)", attributes: .init()
                .font(.system(size: 16))
            )
            
            windSpeed = AttributedString("Wind speed: \(String(format: "%.2f", safeWeathResp.wind.speed))", attributes: .init()
                .font(.system(size: 16))
            )
            
            windDirection = AttributedString("Wind direction: \(WindDirection.getDirection(deg: safeWeathResp.wind.deg))", attributes: .init()
                .font(.system(size: 16))
            )
            
            weathColor = WeatherColors.convertWeatherColor(input: safeWeathResp.weather.first!.main)
            
            weatherCondition = Image(weather: WeatherImage.convertWeatherImage(input: safeWeathResp.weather.first!.main))
            
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
