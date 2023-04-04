//
//  WeatherBackgroundEnum.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

public enum WeatherImage: String {
    case thunder
    case rain
    case sunny
    case snow
    case cloudy
}

extension Image {
    init(weather: WeatherImage) {
        self.init(weather.rawValue)
    }
}



public enum WeatherColors: String {
    case thunder = "thunderColor"
    case clouds = "cloudyColor"
    case sun = "sunnyColor"
}

extension Color {
    init(weather: WeatherColors) {
        self.init(weather.rawValue)
    }
}



public enum WindDirection: String, CaseIterable {
    case n, nne, ne, ene, e, ese, se, sse, s, ssw, sw, wsw, w, wnw, nw, nnw
}

extension WindDirection {
    static func getDirection(deg: Int) -> String {
        let arr = WindDirection.allCases
        let index = Int((Double(deg)/22.5).rounded()) % arr.count
        return arr[index].rawValue.uppercased()
    }
}


