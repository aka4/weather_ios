//
//  WeatherJSON.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 24.03.23.
//

import Foundation

struct WeatherResponse: Codable {
    let coord: Coordinates
    let weather: [Weather]
    let main: MainWeather
    let wind: Wind
    let name: String
}

struct Coordinates: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let main: String
    let description: String
}

struct MainWeather: Codable {
    let temp: Double
    let humidity: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Int
}


