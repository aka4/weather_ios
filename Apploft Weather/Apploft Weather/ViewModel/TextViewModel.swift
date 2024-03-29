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
        private var geoResp: GeoElement = .emptyElement
        
        @Published var dayText = AttributedString(Date.getDay().uppercased(), attributes: .init()
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
        @Published var lastSuccessfulSearch = ""
        @Published var errorShow = false
        @Published var errorText = "Standard Error"
       
        
        @MainActor func executeSearch(city: String?) async {
            isLoaded = false
            var urlCity = ""
            do {
                urlCity = try checkCity(city: city)
                geoResp = try await WeatherAPI.requestCoordinates(city: urlCity)
                weathResp = try await WeatherAPI.requestWeather(lat: geoResp.lat, lon: geoResp.lon)
            } catch let error {
                actOnError(errorType: error)
                return
            }
            if let weathResp {
                print("\(geoResp.name) , \(weathResp.name)")
                changeWeatherInfo(newWeather: weathResp)
                lastSuccessfulSearch = searchText
                resetAfterSuccess()
            }
        }
        
        @MainActor func executeCurrentLocation(coord: (Double, Double)?) async {
            isLoaded = false
            guard let coord else {
                withAnimation {
                    errorShow = true
                    errorText = "Could not find current location"
                }
                print("Coords are nil")
                return
            }
            
            do {
                weathResp = try await WeatherAPI.requestWeather(lat: coord.0, lon: coord.1)
            } catch let error {
                actOnError(errorType: error)
                return
            }
            
            if let weathResp {
                changeWeatherInfo(newWeather: weathResp)
            }
        }

        
        func actOnError(errorType: Error) {
            if let error = errorType as? WeatherError {
                errorText = error.rawValue
            } else {
                errorText = "weird ass error"
            }
            errorShow = true
            isLoaded = true
            searchText = ""
        }
        
        func resetAfterSuccess() {
            isLoaded = true
            searchText = ""
        }
        
        func changeWeatherInfo(newWeather: WeatherResponse) {
            weatherdesc = AttributedString(newWeather.weather.first!.description.uppercased(), attributes: .init()
                .font(.system(size:20))
            )
            
            cityT = AttributedString(newWeather.name.uppercased(), attributes: .init()
                .font(.system(size: 30, weight: .light))
            )
            
            temp = AttributedString("\(Int(newWeather.main.temp))°", attributes: .init()
                .font(.system(size: 100))
            )
            
            humidity = AttributedString("Humidity: \(newWeather.main.humidity)", attributes: .init()
                .font(.system(size: 16))
            )
            
            windSpeed = AttributedString("Wind speed: \(String(format: "%.2f", newWeather.wind.speed))", attributes: .init()
                .font(.system(size: 16))
            )
            
            windDirection = AttributedString("Wind direction: \(WindDirection.getDirection(deg: newWeather.wind.deg))", attributes: .init()
                .font(.system(size: 16))
            )
            
            weathColor = WeatherColors.convertWeatherColor(input: newWeather.weather.first!.main)
            
            weatherCondition = Image(weather: WeatherImage.convertWeatherImage(input: newWeather.weather.first!.main))
            
            isLoaded = true
        }
        
        func checkCity(city: String?) throws -> String {
            guard let city else {
                throw WeatherError.CityNil
            }
            
            if city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                throw WeatherError.EmptyCity
            }
            
            guard let urlCity = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else  {
                throw WeatherError.CityNil
            }
            
            if urlCity.isEmpty {
                throw WeatherError.EmptyCity
            }
            
            return urlCity
        }
    }
}
