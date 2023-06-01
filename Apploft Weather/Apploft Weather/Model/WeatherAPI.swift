//
//  WeatherAPI.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 28.03.23.
//

import Foundation
import Get

class WeatherAPI {
    private static let baseUrl = "http://api.openweathermap.org"
    private static let apiKey = "2949250d0399e038f1e3ec0ccf6bc480"
    
    static func requestWeather(lat: Double, lon: Double) async throws -> WeatherResponse {
        let client = APIClient(baseURL: URL(string: baseUrl))
        
        guard let secURL = URL(string: "\(baseUrl)/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(apiKey)&units=metric") else {
            throw WeatherError.URLDoesNotWork
        }
        
        let request = Request<WeatherResponse>(url: secURL)
        print(request)
        
        do {
            let response = try await client.send(request).value
            return response
        } catch {
            print(error.localizedDescription)
            print("weatherfehler")
            throw WeatherError.NetworkTimeout
        }
    }
    
    static func requestCoordinates(city: String) async throws -> GeoElement {
        let client = APIClient(baseURL: URL(string: "http://api.openweathermap.org"))
        
        guard let secURL = URL(string: "\(baseUrl)/geo/1.0/direct?q=\(city)&limit=1&appid=\(apiKey)") else {
            throw WeatherError.URLDoesNotWork
        }
        
        let request = Request<GeoResponse>(url: secURL)
        print(request)
        
        do {
            let response = try await client.send(request).value
            guard let firstElement = response.first else {
                throw WeatherError.EmptyGeoResponse
            }
            return firstElement
        } catch {
            print(error.localizedDescription)
            print("Geofehler")
            throw WeatherError.NetworkTimeout
        }
    }
}
