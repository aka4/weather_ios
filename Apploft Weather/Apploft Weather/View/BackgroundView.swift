//
//  BackgroundView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct BackgroundView: View {
    let viewModel = ViewModel()
    var body: some View {
        viewModel.weatherCondition
    }
}



struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
