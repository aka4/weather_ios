//
//  BackgroundViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension BackgroundView {
    struct ViewModel {
        let weatherCondition: Image
        
        init(weatherCond: WeatherImage) {
            weatherCondition = Image(weather: weatherCond)
        }
    }
}

extension BackgroundView {
    static let Mock = ViewModel(weatherCond: .thunder)
}
