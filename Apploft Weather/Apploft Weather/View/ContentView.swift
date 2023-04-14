//
//  ContentView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 20.03.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TextView.ViewModel()
    @StateObject private var locationHandler = LocationHandler()
    var body: some View {
        ZStack {
            BackgroundView(viewModel: viewModel)
            VStack {
                SearchView(viewModel: viewModel)
                if viewModel.isLoaded {
                    SquareView(viewModel: viewModel)
                } else {
                    SquareView(viewModel: viewModel)
                        .redacted(reason: .placeholder)
                }
            }
            .padding(30)
        }
        .onChange(of: locationHandler.foundLocation) { newValue in
            Task {
                await viewModel.executeCurrentLocation(coord: locationHandler.coordinates)
            }
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
