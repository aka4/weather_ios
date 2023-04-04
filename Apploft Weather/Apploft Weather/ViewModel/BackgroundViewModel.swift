//
//  BackgroundViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension BackgroundView {
    class ViewModel: ObservableObject {
        @Published var weatherCondition: Image = Image(weather: .cloudy)
    
    }
}

