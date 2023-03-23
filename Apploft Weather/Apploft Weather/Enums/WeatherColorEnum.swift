//
//  WeatherColorEnum.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension Color {
    enum WeatherColors: String{
        case thunder = "thunderColor"
        case clouds = "cloudyColor"
        case sun = "sunnyColor"
    }
    
    init(weather: WeatherColors) {
        self.init(weather.rawValue)
    }
}
