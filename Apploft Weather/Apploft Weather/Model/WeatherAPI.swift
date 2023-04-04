//
//  WeatherAPI.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 28.03.23.
//

import Foundation
import Get

class WeatherAPI {
    
    
    static func requestWeather(lat: Double, lon: Double) async -> WeatherResponse? {
        let client = APIClient(baseURL: URL(string: "http://api.openweathermap.org"))
        
        guard let secURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=2949250d0399e038f1e3ec0ccf6bc480&units=metric") else {
            return nil
        }
        
        let request = Request<WeatherResponse>(url: secURL)
        print(request)
        
        do {
            let response = try await client.send(request).value
            return response
        } catch {
            print(error.localizedDescription)
            print("weatherfehler")
            return nil
        }
    }
    
    static func requestCoordinates(city: String) async -> GeoResponse? {
        let client = APIClient(baseURL: URL(string: "http://api.openweathermap.org"))
        
        guard let secURL = URL(string: "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&limit=1&appid=2949250d0399e038f1e3ec0ccf6bc480") else {
            return nil
        }
        
        let request = Request<GeoResponse>(url: secURL)
        print(request)
        
        do {
            let response = try await client.send(request).value
            return response
        } catch {
            print(error.localizedDescription)
            print("Geofehler")
            return nil
        }
    }
}
