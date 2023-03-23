//
//  ContentViewModel.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

extension TextView {
    struct ViewModel {
        let text: AttributedString
        
        init() {
            text = AttributedString("Hey World", attributes: .init()
                .foregroundColor(Color(weather: .sun))
                .font(.system(size: 30))
            )
        }
    }
}
