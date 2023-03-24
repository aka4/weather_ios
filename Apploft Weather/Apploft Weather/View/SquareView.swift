//
//  SquareView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 24.03.23.
//

import SwiftUI

struct SquareView: View {
    var body: some View {
        Color.white
            .aspectRatio(1, contentMode: .fit)
            .overlay(
                TextView()
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(maxHeight: .infinity, alignment: .bottom)
            
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView()
    }
}
