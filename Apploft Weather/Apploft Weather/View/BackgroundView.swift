//
//  BackgroundView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct BackgroundView: View {
    @ObservedObject var viewModel: TextView.ViewModel
    var body: some View {
        Color.clear
            .overlay {
                viewModel.weatherCondition
                    .resizable()
                    .scaledToFill()
            }
            .ignoresSafeArea(edges: .all)
    }
}



struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView(viewModel: TextView.ViewModel())
    }
}
