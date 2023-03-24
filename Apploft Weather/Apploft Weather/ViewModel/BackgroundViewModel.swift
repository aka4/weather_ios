//
//  BackgroundViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension BackgroundView {
    struct ViewModel {
        let weatherCondition = Image(weather: .sunny)
            .resizable()
    }
}
