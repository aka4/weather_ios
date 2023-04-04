//
//  BackgroundView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct BackgroundView: View {
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        viewModel.weatherCondition
            .resizable()
            .ignoresSafeArea()
            .scaledToFill()
            .onAppear{
                Task {
                    await viewModel.executeSearch(city: "Hamburg")
                }
            }
    }
}



struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
