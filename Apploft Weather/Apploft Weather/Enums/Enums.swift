//
//  WeatherBackgroundEnum.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

//Background Image Enum
public enum WeatherImage: String {
    case thunder
    case rain
    case sunny
    case snow
    case cloudy
}

extension WeatherImage {
    static func convertWeatherImage(input: String) -> WeatherImage {
        switch input {
        case "Thunderstorm":
            return .thunder
        case "Clear":
            return .sunny
        case "Snow":
            return .snow
        case "Drizzle", "Rain":
            return .rain
        default:
            return .cloudy
        }
    }
}

extension Image {
    init(weather: WeatherImage) {
        self.init(weather.rawValue)
    }
}

//Textcolor Enum
public enum WeatherColors: String {
    case thunder = "thunderColor"
    case clouds = "cloudyColor"
    case sun = "sunnyColor"
}

extension WeatherColors {
    static func convertWeatherColor(input: String) -> WeatherColors {
        switch input {
        case "Thunderstorm":
            return .thunder
        case "Clear":
            return .sun
        default:
            return .clouds
        }
    }
}

extension Color {
    init(weather: WeatherColors) {
        self.init(weather.rawValue)
    }
}


//Wind degree to direction Enum
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

public enum WeatherError: String, Error, CaseIterable {
    case NetworkTimeout
    case EmptyGeoResponse
    case EmptyCity
    case CityNil
    case LocationTimeout
    case LocationPermissionNotGranted
    case URLDoesNotWork
    case UnknownError
    
    
}

extension Date {
    
    static func getDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: Date())
        return dayOfTheWeekString
    }
    
}
