//
//  ButtonImageStyle.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 21.09.23.
//

import SwiftUI

extension Image {
    func buttonImageModifier(isLoaded: Bool) -> some View {
        self
            .resizable()
            .frame(width: 30, height: 30)
            .shadow(color: .init(white: 1, opacity: 0.5), radius: 0, y: 3)
            .disabled(!isLoaded)
    }
}
