//
//  WeatherBackgroundEnum.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension Image {
    enum WeatherImage: String {
        case thunder
        case rain
        case sunny
        case snow
        case cloudy
    }
    
    init(weather: WeatherImage) {
        self.init(weather.rawValue)
    }
}

