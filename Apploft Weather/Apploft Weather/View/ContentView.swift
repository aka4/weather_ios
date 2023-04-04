//
//  ContentView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 20.03.23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            SquareView()
                .padding(30)
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
