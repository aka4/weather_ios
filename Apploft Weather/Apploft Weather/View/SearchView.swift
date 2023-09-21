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
            TextField("", text: $viewModel.searchText, prompt: Text("Search city...").foregroundColor(Color("placeholderColor")))
                .focused($focusField, equals: .searchField)
                .onChange(of: focusField) { newValue in
                    show = newValue == .searchField
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 10)
                .foregroundColor(Color(weather: viewModel.weathColor))
                .background {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color("objectColor"))
                        .shadow(color: Color("objectColor").opacity(0.5), radius: 0, y: 3)
                }
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
                    .buttonImageModifier(isLoaded: viewModel.isLoaded)
            }
            Button(action: {
                Task {
                    await viewModel.executeCurrentLocation(coord: locationModel.coordinates)
                }
            }) {
                Image("locationButton")
                    .buttonImageModifier(isLoaded: viewModel.isLoaded)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: TextView.ViewModel(), locationModel: LocationHandler())
    }
}
