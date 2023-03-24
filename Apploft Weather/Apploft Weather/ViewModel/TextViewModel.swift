//
//  ContentViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension TextView {
    struct ViewModel {
        let day: AttributedString
        let weatherdesc: AttributedString
        let city: AttributedString
        
        let temp: Double
        let tempText: AttributedString
        
        let humidity: Int
        let humidText: AttributedString
        
        let windSp: Double
        let windSpText: AttributedString
        
        let windD: String
        let windDText: AttributedString
        
        init() {
            day = AttributedString("TUESDAY", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 30))
            )
            
            weatherdesc = AttributedString("LIGHT RAIN", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 20))
            )
            
            city = AttributedString("LONDON", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 30, weight: .light))
            )
            
            temp = 20
            
            tempText = AttributedString("\(Int(temp))°", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 100))
            )
            
            humidity = 76
            
            humidText = AttributedString("Humidity: \(humidity)", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 16))
            )
            
            windSp = 45.6
            
            windSpText = AttributedString("Wind speed: \(windSp)", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 16))
            )
            
            windD = "N" //logic needed for converting degree from API into String/Enum
            
            windDText = AttributedString("Wind direction: \(windD)", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 16))
            )
        }
    }
}
