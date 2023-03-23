//
//  TextView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 23.03.23.
//

import SwiftUI

struct TextView: View {
    let viewModel = ViewModel()
    var body: some View {
        Text(viewModel.text)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
