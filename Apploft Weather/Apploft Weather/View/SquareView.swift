//
//  SquareView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 24.03.23.
//

import SwiftUI

struct SquareView: View {
    @ObservedObject var viewModel: TextView.ViewModel
    var body: some View {
        Color.white
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                TextView(viewModel: viewModel)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(maxHeight: .infinity, alignment: .bottom)
            .shadow(color: .init(white: 1, opacity: 0.5), radius: 0, y: 10)
            
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(viewModel: TextView.ViewModel())
    }
}
