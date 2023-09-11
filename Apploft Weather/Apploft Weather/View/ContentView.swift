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
                SquareView(viewModel: viewModel)
                    .redacted(reason: viewModel.isLoaded ? [] : .placeholder)
            }
            .padding(30)
        }
        .task(id: locationHandler.foundLocation) {
                await viewModel.executeCurrentLocation(coord: locationHandler.coordinates)
        }
        .onChange(of: viewModel.errorShow || locationHandler.errorFound) { _ in
            withAnimation {
                if viewModel.errorShow {
                    showErr = viewModel.errorShow
                } else if locationHandler.errorFound{
                    showErr = locationHandler.errorFound
                    viewModel.errorText = "Location Permission Error"
                }
            }
        }
        .overlay(overlayView: ToastView(viewModel: viewModel, locationManager: locationHandler, show: $showErr), show: $showErr)
        

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController().container.viewContext)
    }
}
