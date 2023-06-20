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
    @State private var showErr = false
    var body: some View {
        ZStack {
            BackgroundView(viewModel: viewModel)

            VStack {
                SearchView(viewModel: viewModel, locationModel: locationHandler)
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
        .onChange(of: viewModel.errorShow || locationHandler.errorFound) { newValue in
            withAnimation {
                if viewModel.errorShow {
                    showErr = viewModel.errorShow
                } else {
                    showErr = locationHandler.errorFound
                }
            }
        }
        .overlay(overlayView: ToastView(viewModel: viewModel, locationManager: locationHandler, show: $showErr), show: $showErr)
        

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
