//
//  BackgroundViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension BackgroundView {
    class ViewModel: ObservableObject {
        private var weathResp: WeatherResponse?
        private var geoResp: GeoResponse?
        
        @Published var weatherCondition: Image = Image(weather: .cloudy)
    
        @MainActor func executeSearch(city: String) async {
            geoResp = await WeatherAPI.requestCoordinates(city: city)
            
            guard geoResp != nil else {
                return
            }
            
            weathResp = await WeatherAPI.requestWeather(lat: geoResp?.first!.lat ?? 0, lon: geoResp?.first!.lon ?? 0)
            
            weatherCondition = Image(weather: WeatherImage.convertWeatherImage(input: weathResp?.weather.first!.main ?? "Error"))
            
        }
    }
}

