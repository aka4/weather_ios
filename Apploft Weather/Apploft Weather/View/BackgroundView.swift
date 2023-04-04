//
//  BackgroundView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct BackgroundView: View {
    let viewModel = Mock
    var body: some View {
        viewModel.weatherCondition
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
    }
}



struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
