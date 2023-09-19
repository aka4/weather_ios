//
//  SearchView.swift
//  Apploft Weather
//
//  Created by Atakan Özdemir on 11.04.23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: TextView.ViewModel
    @ObservedObject var locationModel: LocationHandler
    @FocusState private var focusField: FocusField?
    @State private var show: Bool = false
    
    var body: some View {
        HStack {
            TextField("Search city...", text: $viewModel.searchText)
                .focused($focusField, equals: .searchField)
                .onChange(of: focusField) { newValue in
                    show = newValue == .searchField
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(Color(weather: viewModel.weathColor))
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                }
                .shadow(color: .init(white: 1, opacity: 0.5), radius: 0, y: 5)
                .popover(
                    isPresented: $show,
                    attachmentAnchor: .point(.bottom),
                    content: {
                        PopoverListView(viewModel: viewModel)
                            .frame(minWidth: 200, minHeight: 300)
                })
            Button(action: {
                Task {
                    await viewModel.executeSearch(city: viewModel.searchText)
                }
            }) {
                Image("sendButton")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .shadow(color: .init(white: 1, opacity: 0.5), radius: 0, y: 3)
                    .disabled(!viewModel.isLoaded)
            }
            Button(action: {
                Task {
                    await viewModel.executeCurrentLocation(coord: locationModel.coordinates)
                }
            }) {
                Image("locationButton")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .shadow(color: .init(white: 1, opacity: 0.5), radius: 0, y: 3)
                    .disabled(!viewModel.isLoaded)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: TextView.ViewModel(), locationModel: LocationHandler())
    }
}
