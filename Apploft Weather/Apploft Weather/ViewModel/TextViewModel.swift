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
        
        @Published var dayText = AttributedString(getDay(), attributes: .init()
            .font(.system(size: 30))
        )
        
        @Published var weatherdesc = AttributedString("")
        
        @Published var cityT = AttributedString("")
        
        @Published var temp = AttributedString("")
        
        @Published var humidity = AttributedString("")
        
        @Published var windSpeed = AttributedString("")
        
        @Published var windDirection = AttributedString("")
       
        
        func retrieveData() {
            guard let weathUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=53.551086&lon=9.993682&appid=2949250d0399e038f1e3ec0ccf6bc480&units=metric") else {
                return
            }
            URLSession.shared.dataTask(with: weathUrl) { data, response, error in
                let decoder = JSONDecoder()
                if let dataB = data {
                    do {
                        self.weathResp = try decoder.decode(WeatherResponse.self, from: dataB)
                    } catch {
                        print(error.localizedDescription)
                        print(self.weathResp ?? "Null")
                    }
                }
            }
            .resume()
        }
        
        @MainActor func executeSearch(city: String) async {
            geoResp = await WeatherAPI.requestCoordinates(city: city)
            guard geoResp != nil else {
                return
            }
            weathResp = await WeatherAPI.requestWeather(lat: geoResp?.first!.lat ?? 0, lon: geoResp?.first!.lon ?? 0)
            //weathResp = await WeatherAPI.requestWeather(lat: 53.090, lon: 9.0)
            
            weatherdesc = AttributedString(weathResp?.weather.first!.description ?? "Error", attributes: .init()
                .font(.system(size:20))
            )
            
            cityT = AttributedString(weathResp?.name ?? "Error", attributes: .init()
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
            
            windDirection = AttributedString("Wind direction: \(weathResp?.wind.deg ?? 0)", attributes: .init()
                .font(.system(size: 16))
            )
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
